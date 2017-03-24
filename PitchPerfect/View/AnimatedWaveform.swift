//
//  AnimatedWaveform.swift
//  PitchPerfect
//
//  Created by Shobhit Gupta on 23/03/17.
//  Copyright © 2017 Shobhit Gupta. All rights reserved.
//

import UIKit
import SwiftSiriWaveformView


class AnimatedWaveform: SwiftSiriWaveformView {

    var timer:Timer?
    var change:CGFloat = 0.01
    var shouldHideWhenNotAnimating = false

    func begin() {
        fadeIn(duration: 0.5)
        timer = Timer.scheduledTimer(timeInterval: 3.0 / Double(bounds.width), target: self, selector: #selector(AnimatedWaveform.refreshAudioView(_:)), userInfo: nil, repeats: true)
    }
    
    
    func end(completition: @escaping (Bool) -> Void = {(finished) in }) {
        guard let timer = timer else {
            print("AnimatedWaveform: No timer found")
            return
        }
        
        if shouldHideWhenNotAnimating {
            fadeOut(duration: 0.5) { (finished) in
                timer.invalidate()
                completition(finished)
            }
        } else {
            timer.invalidate()
            completition(true)
        }
        
        
    }
    
    
    internal func refreshAudioView(_:Timer) {
        if self.amplitude <= self.idleAmplitude || self.amplitude > 1.0 {
            self.change *= -1.0
        }
        self.amplitude += self.change
    }
    
}
