//
//  AVAudioEngine+Convenience.swift
//  PitchPerfect
//
//  Created by Shobhit Gupta on 27/03/17.
//  Copyright © 2017 Shobhit Gupta. All rights reserved.
//

import Foundation
import AVFoundation


public extension AVAudioEngine {
    
    public func attach(audioNodes nodes: [AVAudioNode]) {
        nodes.forEach {
            attach($0)
        }
    }
    
    
    public func attach(audioNodes nodes: AVAudioNode...) {
        attach(audioNodes: nodes)
    }
    
    
    public func connect(audioNodes nodes: [AVAudioNode], format: AVAudioFormat?) {
        for i in 0 ..< nodes.count - 1 {
            connect(nodes[i], to: nodes[i+1], format: format)
        }
    }
    
    
    public func connect(audioNodes nodes: AVAudioNode..., format: AVAudioFormat?) {
        connect(audioNodes: nodes, format: format)
    }
    
    
    public func disconnectInput(of nodes: [AVAudioNode]) {
        nodes.forEach {
            disconnectNodeInput($0)
        }
    }
    
    
    public func disconnectInput(of nodes: AVAudioNode...) {
        disconnectInput(of: nodes)
    }
    
}

