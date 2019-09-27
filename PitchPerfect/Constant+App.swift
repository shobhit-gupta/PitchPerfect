//
//  Constant+App.swift
//  PitchPerfect
//
//  Created by Shobhit Gupta on 24/03/17.
//  Copyright © 2017 Shobhit Gupta. All rights reserved.
//

import Foundation
import UIKit


extension Constant {
    
    enum StatusBarStyle {
        static let RecordViewController: UIStatusBarStyle = .lightContent
        static let AudioEffectsViewController: UIStatusBarStyle = .lightContent
    }
    
    enum CircularSlider {
        static let LineWidth: CGFloat = 5.0
        static let ThumbLineWidth: CGFloat = 2.0
        static let ThumbRadius: CGFloat = 2.0
        static let GradientOpacity: CGFloat = 0.4
    }
    
    enum Waveform {
        static let ChangePerFrameInAmplitude: CGFloat = 0.01
        static let FadeInDuration: TimeInterval = 0.5
        static let FadeOutDuration: TimeInterval = 0.5
    }
    
    enum Wheel {
        static let DefaultSector = 0
    }
    
    enum Segue {
        static let ShowAudioEffects = "showAudioEffects"
    }
    
}


extension Constant.Audio {
    enum Effect {
        enum Factor {
            static let Minimum = 0
            static let Maximum = 12
            static let Default = 6
        }
    }
}
