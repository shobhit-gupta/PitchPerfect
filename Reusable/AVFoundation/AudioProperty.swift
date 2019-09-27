//
//  AudioProperties.swift
//  PitchPerfect
//
//  Created by Shobhit Gupta on 26/03/17.
//  Copyright © 2017 Shobhit Gupta. All rights reserved.
//

import Foundation
import AVFoundation


public enum AudioProperty {
    
    case rate(value: Float)
    case pitch(value: Float)
    case distortion(preset: AVAudioUnitDistortionPreset, preGain: Float?, wetDryMix: Float?)
    case reverb(preset: AVAudioUnitReverbPreset, wetDryMix: Float?)
    
    func configure(audioNode: AVAudioNode) throws {
        switch self {
        case .rate(let rate):
            guard let node = audioNode as? AVAudioUnitTimePitch else {
                throw Error_.Audio.Property.Incompatible(property: self, with: audioNode)
            }
            node.rate = rate
            
        case .pitch(let pitch):
            guard let node = audioNode as? AVAudioUnitTimePitch else {
                throw Error_.Audio.Property.Incompatible(property: self, with: audioNode)
            }
            node.pitch = pitch
            
        case let .reverb(preset, wetDryMix):
            guard let node = audioNode as? AVAudioUnitReverb else {
                throw Error_.Audio.Property.Incompatible(property: self, with: audioNode)
            }
            node.loadFactoryPreset(preset)
            if let wetDryMix = wetDryMix {
                node.wetDryMix = wetDryMix
            }
            
        case let .distortion(preset, preGain, wetDryMix):
            guard let node = audioNode as? AVAudioUnitDistortion else {
                throw Error_.Audio.Property.Incompatible(property: self, with: audioNode)
            }
            node.loadFactoryPreset(preset)
            if let preGain = preGain {
                node.preGain = preGain
            }
            if let wetDryMix = wetDryMix {
                node.wetDryMix = wetDryMix
            }
            
        }
    }
    
}


public extension Constant.Audio.Default {
    
    static var Properties: [AudioProperty] {
        var property = [AudioProperty]()
        property.append(.rate(value: Rate))
        property.append(.pitch(value: Pitch))
        if Distortion.Exist {
            property.append(.distortion(preset: Distortion.Preset, preGain: Distortion.PreGain, wetDryMix: Distortion.WetDryMix))
        }
        if Reverb.Exist {
            property.append(.reverb(preset: Reverb.Preset, wetDryMix: Reverb.WetDryMix))
        }
        return property
    }

}


public extension Error_.Audio {
    
    enum Property: Error {
        case Incompatible(property: AudioProperty, with: AVAudioNode)
        
        var localizedDescription: String {
            // TODO: See if this error is being caught or not.
            var description = String(describing: self)
            switch self {
            case let .Incompatible(property, node):
                description += "\(property) incompatible with \(node)"
            }
            return description
        }
    }
}
