//
//  AudioPlayer.swift
//  PitchPerfect
//
//  Created by Shobhit Gupta on 27/03/17.
//  Copyright © 2017 Shobhit Gupta. All rights reserved.
//

import Foundation
import AVFoundation


class BasicAudioPlayer: NSObject {
    
    public var isPlaying: Bool {
        return audioPlayerNode.isPlaying
    }
    
    
    fileprivate let audioEngine: AVAudioEngine
    fileprivate let audioPlayerNode: AVAudioPlayerNode
    fileprivate let pitchAndRateNode: AVAudioUnitTimePitch
    fileprivate let distortionNode: AVAudioUnitDistortion
    fileprivate let reverbNode: AVAudioUnitReverb
    
    fileprivate var nodes: [AVAudioNode] {
        return [audioPlayerNode, pitchAndRateNode, distortionNode, reverbNode]
    }
    
    fileprivate var hasDistortion: Bool
    fileprivate var hasReverb: Bool
    
    
    override init() {
        audioEngine = AVAudioEngine()
        audioPlayerNode = AVAudioPlayerNode()
        pitchAndRateNode = AVAudioUnitTimePitch()
        distortionNode = AVAudioUnitDistortion()
        reverbNode = AVAudioUnitReverb()
        hasDistortion = Constant.Audio.Default.hasDistortion
        hasReverb = Constant.Audio.Default.hasReverb
        super.init()
        
        // Attach audio nodes to engine
        audioEngine.attach(audioNodes: nodes)
    }
    
    
    deinit {
        stop()
    }
    
    
    public func play(_ audioURL: URL, with properties: [AudioProperty]) throws {
        let audioFile = try AVAudioFile(forReading: audioURL)
        try play(audioFile, with: properties)
    }
    
    
    public func play(_ audioFile: AVAudioFile, with properties: [AudioProperty]) throws {
        prepareForFreshPlayback()
        try syncNodes(with: properties)
        connectNodes(format: audioFile.processingFormat)
        prepareForPlaying(audioFile: audioFile)
        audioEngine.prepare()
        try audioEngine.start()
        audioPlayerNode.play()
    }
    
    
    public func stop() {
        if audioPlayerNode.isPlaying {
            audioPlayerNode.stop()
        }
        
        if audioEngine.isRunning {
            audioEngine.stop()
            audioEngine.reset()
        }
    }
    
    
    fileprivate func prepareForFreshPlayback() {
        stop()
        pitchAndRateNode.rate = Constant.Audio.Default.Rate
        pitchAndRateNode.pitch = Constant.Audio.Default.Pitch
        hasDistortion = Constant.Audio.Default.hasDistortion
        hasReverb = Constant.Audio.Default.hasReverb
        audioEngine.disconnectInput(of: nodes)
    }
    
    
    private func syncNodes(with properties: [AudioProperty]) throws {
        for property in properties {
            switch property {
            case .rate:
                try property.configure(audioNode: pitchAndRateNode)
            case .pitch:
                try property.configure(audioNode: pitchAndRateNode)
            case .distortion:
                try property.configure(audioNode: distortionNode)
                hasDistortion = true
            case .reverb:
                try property.configure(audioNode: reverbNode)
                hasReverb = true
            }
        }
    }
    
    
    private func prepareForPlaying(audioFile: AVAudioFile) {
        audioPlayerNode.scheduleFile(audioFile, at: nil, completionHandler: nil)
    }
    
    
    fileprivate func connectNodes(format: AVAudioFormat?) {
        switch (hasDistortion, hasReverb) {
        case (true, true):
            audioEngine.connect(audioNodes: audioPlayerNode, pitchAndRateNode, distortionNode, reverbNode, audioEngine.outputNode, format: format)
        case (true, false):
            audioEngine.connect(audioNodes: audioPlayerNode, pitchAndRateNode, distortionNode, audioEngine.outputNode, format: format)
        case (false, true):
            audioEngine.connect(audioNodes: audioPlayerNode, pitchAndRateNode, reverbNode, audioEngine.outputNode, format: format)
        case (false, false):
            audioEngine.connect(audioNodes: audioPlayerNode, pitchAndRateNode, audioEngine.outputNode, format: format)
        }
    }
    
}










