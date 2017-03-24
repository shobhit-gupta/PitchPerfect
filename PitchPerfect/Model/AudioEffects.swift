//
//  AudioEffects.swift
//  PitchPerfect
//
//  Created by Shobhit Gupta on 24/03/17.
//  Copyright © 2017 Shobhit Gupta. All rights reserved.
//

import Foundation
import UIKit


enum AudioEffects: Int {
    
    case high, fast, reverb, low, slow, echo
    
    func image() -> UIImage {
        return AudioEffects.image(for: self)
    }
    
    
    static func image(for audioEffect: AudioEffects.RawValue) -> UIImage {
        return AudioEffects.image(for: audioEffect.hashValue)
    }
    
    
    static func image(for audioEffect: AudioEffects) -> UIImage {
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
