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
    func audioProperties() -> [AudioProperty] {
        let properties: [AudioProperty]
        switch self {
        case .high:
            properties = [.pitch(pitch: 1000.0), .rate(rate: 1.0)]
        case .fast:
            properties = [.rate(rate: 1.5), .pitch(pitch: 1.0)]
        case .reverb:
            properties = [.reverb(preset: .cathedral), .rate(rate: 1.0), .pitch(pitch: 1.0)]
        case .low:
            properties = [.pitch(pitch: -1000.0), .rate(rate: 1.0)]
        case .slow:
            properties = [.rate(rate: 0.5), .pitch(pitch: 1.0)]
        case .echo:
            properties = [.distortion(preset: .multiEcho1), .rate(rate: 1.0), .pitch(pitch: 1.0)]
        }
        
        return properties
    }
}
