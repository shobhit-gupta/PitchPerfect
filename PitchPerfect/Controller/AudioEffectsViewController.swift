//
//  AudioEffectsViewController.swift
//  PitchPerfect
//
//  Created by Shobhit Gupta on 20/03/17.
//  Copyright © 2017 Shobhit Gupta. All rights reserved.
//

import UIKit
import HCRotaryWheel
import HGCircularSlider


class AudioEffectsViewController: CustomTraitCollectionViewController {

    @IBOutlet weak var wheel: RotaryWheel!
    @IBOutlet weak var closeButton: ArtKitButton!
    @IBOutlet weak var circularSlider: CircularSlider!
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.kind = .close
        closeButton.backgroundColor = ArtKit.primaryColor
        view.backgroundColor = ArtKit.primaryColor
        setupWheel()
        setupCircularSlider()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @IBAction func close(_ sender: ArtKitButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLayoutSubviews() {
        wheel.redraw()
        circularSlider.setNeedsDisplay()
    }
}


extension AudioEffectsViewController: RotaryProtocol {
    
    
    
    func wheelDidChangeValue(_ currentSector: Int32) {
        
    }
    
}


extension AudioEffectsViewController {
    
    func setupWheel() {
        wheel.background = ArtKit.primaryColor
        wheel.rotaryImage1 = ArtKit.imageOfHigh
        wheel.rotaryImage2 = ArtKit.imageOfFast
        wheel.rotaryImage3 = ArtKit.imageOfReverb
        wheel.rotaryImage4 = ArtKit.imageOfLow
        wheel.rotaryImage5 = ArtKit.imageOfSlow
        wheel.rotaryImage6 = ArtKit.imageOfEcho
        wheel.delegate = self
    }
    
    
    func setupCircularSlider() {
        circularSlider.trackColor = ArtKit.shadowOfPrimaryColor
        circularSlider.trackFillColor = ArtKit.highlightOfPrimaryColor
        circularSlider.endThumbStrokeColor = ArtKit.shadowOfPrimaryColor.withAlphaComponent(0.2)
        circularSlider.endThumbStrokeHighlightedColor = ArtKit.highlightOfPrimaryColor.withAlphaComponent(0.2)
    }
}
