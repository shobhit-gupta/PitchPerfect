//
//  AudioEffect.swift
//  PitchPerfect
//
//  Created by Shobhit Gupta on 24/03/17.
//  Copyright © 2017 Shobhit Gupta. All rights reserved.
//

import Foundation
import UIKit


enum AudioEffect: Int {
    
    case high = 1, fast, reverb, low, slow, echo
    
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
