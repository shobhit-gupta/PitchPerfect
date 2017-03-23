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
        fadeIn()
        self.timer = Timer.scheduledTimer(timeInterval: 3.0 / Double(self.bounds.width), target: self, selector: #selector(AnimatedWaveform.refreshAudioView(_:)), userInfo: nil, repeats: true)
    }
    
    
    func end() {
        guard let timer = timer else {
            print("AnimatedWaveform: No timer found")
            return
        }
        
        if shouldHideWhenNotAnimating {
            fadeOut()
        }
        timer.invalidate()
    }
    
    
    internal func refreshAudioView(_:Timer) {
        if self.amplitude <= self.idleAmplitude || self.amplitude > 1.0 {
            self.change *= -1.0
        }
        self.amplitude += self.change
    }
    
    
    func fadeIn() {
        if alpha < 1.0 {
            UIView.animate(withDuration: 0.5,
                           delay: 0.0,
                           options: .curveEaseInOut,
                           animations: { self.alpha = 1.0 })
        }
    }
    
    
    func fadeOut() {
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: { self.alpha = 0.0 })
    }
    
    
    
}
