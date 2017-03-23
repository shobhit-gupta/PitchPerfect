//
//  CircularSliderGradient.swift
//  PitchPerfect
//
//  Created by Shobhit Gupta on 22/03/17.
//  Copyright © 2017 Shobhit Gupta. All rights reserved.
//

import UIKit
import HGCircularSlider

@IBDesignable
class CircularSliderGradient: UIView {

    @IBInspectable var opacity: CGFloat = 0.4
    @IBInspectable var sliderLineWidth: CGFloat = 5.0
    @IBInspectable var sliderThumbLineWidth: CGFloat = 4.0
    @IBInspectable var sliderThumbRadius: CGFloat = 13.0
    
    
    var radius: CGFloat {
        get {
            // the minimum between the height/2 and the width/2
            var radius =  min(bounds.midX, bounds.midY)
            // all elements should be inside the view rect, for that we should subtract the highest value between the radius of thumb and the line width
            radius -= max(sliderLineWidth, (sliderThumbRadius + sliderThumbLineWidth))
            return radius
        }
    }
    
    
    override func draw(_ rect: CGRect) {
        let sliderRadius = radius
        let gradientRect = CGRect(x: bounds.midX - sliderRadius,
                                  y: bounds.midY - sliderRadius,
                                  width: sliderRadius * 2,
                                  height: sliderRadius * 2)
        ArtKit.drawCircularSliderGradient(frame: gradientRect, opacity: opacity)
    }

}


extension CircularSliderGradient {
    
    func sync(with circularSlider: CircularSlider) {
        sliderLineWidth = circularSlider.lineWidth
        sliderThumbLineWidth = circularSlider.thumbLineWidth
        sliderThumbRadius = circularSlider.thumbRadius
        setNeedsDisplay()
    }

}
