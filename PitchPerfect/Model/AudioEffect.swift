//
//  AudioEffect.swift
//  PitchPerfect
//
//  Created by Shobhit Gupta on 24/03/17.
//  Copyright © 2017 Shobhit Gupta. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation


enum AudioEffect: Int {
    
    case high = 1, fast, reverb, low, slow, echo
    
}


extension AudioEffect {
    
    func image() -> UIImage {
        return AudioEffect.image(for: self)
    }
    
    
    static func image(for audioEffect: AudioEffect.RawValue) -> UIImage? {
        if let audioEffect = AudioEffect(rawValue: audioEffect) {
            return AudioEffect.image(for: audioEffect)
        }
        return nil
    }
    
    
    static func image(for audioEffect: AudioEffect) -> UIImage {
        let image: UIImage
        switch audioEffect {
        case .high:
            image = ArtKit.imageOfHigh
        case .fast:
            image = ArtKit.imageOfFast
        case .reverb:
            image = ArtKit.imageOfReverb
        case .low:
            image = ArtKit.imageOfLow
        case .slow:
            image = ArtKit.imageOfSlow
        case .echo:
            image = ArtKit.imageOfEcho
        }
        
        return image
    }
    
}


extension AudioEffect {
    
    // TODO: Fine tune this while testing after adding the slider measure
    func audioProperties(scaledBy factor: Int = Constant.Audio.Effect.Factor.Default) -> [AudioProperty] {
        
        guard case Constant.Audio.Effect.Factor.Minimum...Constant.Audio.Effect.Factor.Maximum = factor else {
            return Constant.Audio.Default.Properties()
        }
        
        // Normalize
        let factor = Float(factor) - Float(Constant.Audio.Effect.Factor.Minimum)
        let range = Float(Constant.Audio.Effect.Factor.Maximum - Constant.Audio.Effect.Factor.Minimum)
        
        // This condition can be served in above guard statement but, it's 
        // not an appropriate place for it.
        if factor == 0.0 {
            return Constant.Audio.Default.Properties()
        }
        
        let properties: [AudioProperty]
        switch self {
        case .high:
            properties = [.pitch(value: 2000.0 * factor / range), .rate(value: 1.0)]
        case .fast:
            properties = [.rate(value: 1.0 + factor / range), .pitch(value: 1.0)]
        case .reverb:
            properties = [.reverb(preset: .cathedral), .rate(value: 1.0), .pitch(value: 1.0)]
        case .low:
            properties = [.pitch(value: -2000.0 * factor / range), .rate(value: 1.0)]
        case .slow:
            properties = [.rate(value: 1.0 - factor / (1.5 * range)), .pitch(value: 1.0)]
        case .echo:
            properties = [.distortion(preset: .multiEcho1), .rate(value: 1.0), .pitch(value: 1.0)]
        }
        
        return properties
    }
}
