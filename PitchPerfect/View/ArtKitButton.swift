//
//  OverlayButton.swift
//  PitchPerfect
//
//  Created by Shobhit Gupta on 20/03/17.
//  Copyright © 2017 Shobhit Gupta. All rights reserved.
//

import UIKit

class ArtKitButton: UIButton {
    
    enum ButtonKind {
        case close
        case microphone
    }
    
    enum blendingMode {
        case normal
        case overlay
    }

    var kind: ButtonKind = .microphone {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var currentState: blendingMode = .normal {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    override func draw(_ rect: CGRect) {
        switch (kind, currentState) {
        case (.microphone, .normal):
            ArtKit.drawMicrophoneButton(frame: bounds, isPressed: false)
        case (.microphone, .overlay):
            ArtKit.drawMicrophoneButton(frame: bounds, isPressed: true)
        case (.close, .normal), (.close, .overlay):
            ArtKit.drawClose(frame: bounds)
        }
    }
    

}
