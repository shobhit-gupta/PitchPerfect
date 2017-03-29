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
    case distortion(preset: AVAudioUnitDistortionPreset)
    case reverb(preset: AVAudioUnitReverbPreset)
    
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
            
        case .reverb(let preset):
            guard let node = audioNode as? AVAudioUnitReverb else {
                throw Error_.Audio.Property.Incompatible(property: self, with: audioNode)
            }
            node.loadFactoryPreset(preset)
            
        case .distortion(let preset):
            guard let node = audioNode as? AVAudioUnitDistortion else {
                throw Error_.Audio.Property.Incompatible(property: self, with: audioNode)
            }
            node.loadFactoryPreset(preset)
            
        }
    }
    
}


public extension Constant.Audio.Default {
    
    static func Properties() -> [AudioProperty] {
        var property = [AudioProperty]()
        property.append(.rate(value: Rate))
        property.append(.pitch(value: Pitch))
        if hasDistortion {
            property.append(.distortion(preset: Distortion))
        }
        if hasReverb {
            property.append(.reverb(preset: Reverb))
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
