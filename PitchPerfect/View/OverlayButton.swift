//
//  OverlayButton.swift
//  PitchPerfect
//
//  Created by Shobhit Gupta on 20/03/17.
//  Copyright © 2017 Shobhit Gupta. All rights reserved.
//

import UIKit

class OverlayButton: UIButton {
    
    enum state {
        case normal
        case overlay
    }

    var currentState: state = .normal {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    override func draw(_ rect: CGRect) {
        switch currentState {
        case .normal:
            ArtKit.drawMicrophoneButton(frame: bounds, isPressed: false)
        case .overlay:
            ArtKit.drawMicrophoneButton(frame: bounds, isPressed: true)
        }
    }
 
    
    
    
    

}
