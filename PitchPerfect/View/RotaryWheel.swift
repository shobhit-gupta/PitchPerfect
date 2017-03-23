//
//  RotaryWheel.swift
//  PitchPerfect
//
//  Created by Shobhit Gupta on 22/03/17.
//  Copyright © 2017 Shobhit Gupta. All rights reserved.
//
//  HCRotaryWheel for PitchPerfect project

import Foundation
import HCRotaryWheel


class RotaryWheel: HCRotaryWheel {
    
    var shouldUseTimer = false
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if !shouldUseTimer {
            removeTimer()
        }
    }
    
    
    func removeTimer() {
        if timerExists() {
            stopTimer()
        }
    }
    
    
    func redraw() {
        // Remove existing drawing
        layer.sublayers = nil
        
        // Redraw
        setNeedsDisplay()
    }
    
    
}
