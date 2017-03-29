//
//  Constant.swift
//  PitchPerfect
//
//  Created by Shobhit Gupta on 26/03/17.
//  Copyright © 2017 Shobhit Gupta. All rights reserved.
//

import Foundation

public enum Constant {
    // Extend Constant in individual files.
    // Then import this file along with specific files that need to be reused in future projects.
}


// Add/Remove or Comment/Uncomment nested enums according to which piece of code you reuse.


public extension Constant {
    
    enum UIView_ {
        
    }

    enum FileManager_ {
        
    }
    
    enum Audio {
        
    }
    
}


import AVFoundation
public extension Constant.Audio {
    
        enum Default {
            static let Rate: Float = 1.0
            static let Pitch: Float = 1.0
            static let Distortion: AVAudioUnitDistortionPreset = .multiEcho1
            static let Reverb: AVAudioUnitReverbPreset = .cathedral
            static let hasDistortion = false
            static let hasReverb = false
        }
        
}
