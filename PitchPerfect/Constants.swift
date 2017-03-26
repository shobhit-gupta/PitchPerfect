//
//  Constants.swift
//  PitchPerfect
//
//  Created by Shobhit Gupta on 24/03/17.
//  Copyright © 2017 Shobhit Gupta. All rights reserved.
//

import Foundation
import UIKit


enum Constants {
    
    enum Recording {
        static let DataContainerDirectory: FileManager.SearchPathDirectory = .documentDirectory
        static let DomainMask: FileManager.SearchPathDomainMask = .userDomainMask
        static let Folder = "Recordings"
        static let FileExtension = "wav"
        
    }
    
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
    
}
