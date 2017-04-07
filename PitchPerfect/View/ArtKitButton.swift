//
//  ArtKitButton.swift
//  PitchPerfect
//
//  Created by Shobhit Gupta on 20/03/17.
//  Copyright © 2017 Shobhit Gupta. All rights reserved.
//

import UIKit

class ArtKitButton: UIButton {
    
    enum BlendMode {
        case normal
        case overlay
    }
    
    enum ArtButtonKind {
        case close
        case microphone(blendMode: BlendMode)
    }
    

    var kind: ArtButtonKind = .microphone(blendMode: .normal) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    override func draw(_ rect: CGRect) {
        switch kind {
        case .microphone(blendMode: .normal):
            ArtKit.drawMicrophoneButton(frame: bounds, isPressed: false)
        case .microphone(blendMode: .overlay):
            ArtKit.drawMicrophoneButton(frame: bounds, isPressed: true)
        case .close:
            ArtKit.drawClose(frame: bounds)
        }
    }
    

}
