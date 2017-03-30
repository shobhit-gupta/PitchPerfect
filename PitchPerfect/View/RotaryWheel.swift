//
//  RotaryWheel.swift
//  PitchPerfect
//
//  Created by Shobhit Gupta on 22/03/17.
//  Copyright © 2017 Shobhit Gupta. All rights reserved.
//
//  Adapt HCRotaryWheel for PitchPerfect project

import Foundation
import HCRotaryWheel


class RotaryWheel: HCRotaryWheel {
    
    var shouldUseTimer = false
    var rotateToSector: Int = Constant.Wheel.DefaultSector
    
    // HCRotaryWheel & it's control offers no interface to distinguish between
    // user initiated tracking based rotation and rotation due to some other 
    // reasons (like timers etc.)
    var isUserInitiated = true
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // HCRotaryWheel sets the timer in the drawRect method.
        // So remove it after each time the wheel is drawn.
        if !shouldUseTimer {
            removeTimer()
        }
        isUserInitiated = false
        rotate(to: rotateToSector)
        isUserInitiated = true
    }
    
    
    // HCRotaryWheel offers no interface for rotating to a particular sector
    func rotate(to sector: Int) {
        let sector = sector % Int(numberOfSections)
        while Int(currentSector) != sector {
            rotate()
        }
    }
    
    // HCRotaryWheel offers no interface to disable the timer
    func removeTimer() {
        if timerExists() {
            stopTimer()
        }
    }
    
    
    // HCRotaryWheel doesn't adapt to changing superview sizes
    func redraw() {
        // Remove existing drawing or rather subviews in this case
        subviews.forEach {
            $0.removeFromSuperview()
        }
        
        // Store the current sector to ensure that it will be the 'currentSector' after redrawing.
        rotateToSector = Int(currentSector)
        
        // Redraw
        setNeedsDisplay()
    }
    
}
