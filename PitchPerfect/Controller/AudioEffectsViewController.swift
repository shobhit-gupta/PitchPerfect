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
    @IBOutlet weak var circularSliderGradient: CircularSliderGradient!
    @IBOutlet weak var circularSlider: CircularSlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    
    override func viewDidLayoutSubviews() {
        wheel.redraw()
        circularSlider.setNeedsDisplay()
        circularSliderGradient.sync(with: circularSlider)
        circularSliderGradient.setNeedsDisplay()
    }

    
    @IBAction func close(_ sender: ArtKitButton) {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
}


extension AudioEffectsViewController: RotaryProtocol {
    
    func wheelDidChangeValue(_ currentSector: Int32) {
        // TODO: Apply audio effects
    }
    
}


extension AudioEffectsViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    func setupUI() {
        setupView()
        setupCloseButton()
        setupWheel()
        setupCircularSlider()
        setupCircularSliderGradient()
    }
    
    
    func setupView() {
        view.backgroundColor = ArtKit.primaryColor
    }
    
    
    func setupCloseButton() {
        closeButton.kind = .close
        closeButton.backgroundColor = ArtKit.primaryColor
    }
    
    
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
        // Disk
        circularSlider.diskColor = UIColor.clear
        circularSlider.diskFillColor = UIColor.clear
        
        // Track
        circularSlider.trackColor = ArtKit.shadowOfPrimaryColor
        circularSlider.trackFillColor = ArtKit.highlightOfPrimaryColor
        circularSlider.lineWidth = 5.0
        
        // Thumb
        circularSlider.thumbLineWidth = 2.0
        circularSlider.thumbRadius = 2.0
        circularSlider.endThumbTintColor = ArtKit.secondaryColor
        circularSlider.endThumbStrokeColor = ArtKit.secondaryColor
        circularSlider.endThumbStrokeHighlightedColor = ArtKit.secondaryColor
    }
    
    
    func setupCircularSliderGradient() {
        circularSliderGradient.sync(with: circularSlider)
    }
    
}
