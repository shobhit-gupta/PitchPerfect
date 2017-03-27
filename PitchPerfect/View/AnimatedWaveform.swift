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
    var change:CGFloat = Constant.Waveform.ChangePerFrameInAmplitude
    var shouldHideWhenNotAnimating = false

    func begin() {
        fadeIn(duration: Constant.Waveform.FadeInDuration)
        timer = Timer.scheduledTimer(timeInterval: 3.0 / Double(bounds.width), target: self, selector: #selector(AnimatedWaveform.refreshAudioView(_:)), userInfo: nil, repeats: true)
    }
    
    
    func end(completition: @escaping (Bool) -> Void = {(finished) in }) {
        guard let timer = timer else {
            debugPrint("AnimatedWaveform: No timer found")
            return
        }

        func fadeOutCompletion(priorWorkFinished: Bool) {
            timer.invalidate()
            completition(priorWorkFinished)
        }
        
        
        if shouldHideWhenNotAnimating {
            fadeOut(duration: Constant.Waveform.FadeOutDuration) { (finished) in
                fadeOutCompletion(priorWorkFinished: finished)
            }
        } else {
            fadeOutCompletion(priorWorkFinished: true)
        }
        
    }
    
    
    internal func refreshAudioView(_:Timer) {
        if self.amplitude <= self.idleAmplitude || self.amplitude > 1.0 {
            self.change *= -1.0
        }
        self.amplitude += self.change
    }
    
}
