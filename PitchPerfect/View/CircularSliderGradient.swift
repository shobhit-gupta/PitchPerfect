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
public class CircularSliderGradient: UIView {

    @IBInspectable public var opacity: CGFloat = Constant.CircularSlider.GradientOpacity
    @IBInspectable public var sliderLineWidth: CGFloat = Constant.CircularSlider.LineWidth
    @IBInspectable public var sliderThumbLineWidth: CGFloat = Constant.CircularSlider.ThumbLineWidth
    @IBInspectable public var sliderThumbRadius: CGFloat = Constant.CircularSlider.ThumbRadius
    
    
    internal var radius: CGFloat {
        // the minimum between the height/2 and the width/2
        var radius =  min(bounds.midX, bounds.midY)
        // all elements should be inside the view rect, for that we should subtract the highest value between the radius of thumb and the line width
        radius -= max(sliderLineWidth, (sliderThumbRadius + sliderThumbLineWidth))
        return radius
    }
    
    
    override public func draw(_ rect: CGRect) {
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
