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
    
    enum State {
        case playing
        case notPlaying
    }

    @IBOutlet weak var wheel: RotaryWheel!
    @IBOutlet weak var closeButton: ArtKitButton!
    @IBOutlet weak var circularSliderGradient: CircularSliderGradient!
    @IBOutlet weak var circularSlider: CircularSlider!
    
    var currentState: State = .notPlaying {
        didSet {
            updateUI()
        }
    }
    
    var currentEffect: AudioEffects?
    
    
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
    
    
    func updateUI() {
        switch currentState {
        case .playing:
            break
        case .notPlaying:
            break
        }
    }

    
    @IBAction func close(_ sender: ArtKitButton) {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
}


extension AudioEffectsViewController: RotaryProtocol {
    
    func wheelDidChangeValue(_ currentSector: Int32) {
        currentEffect = AudioEffects(rawValue: Int(currentSector))
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
        wheel.rotaryImage1 = AudioEffects.image(for: 1)
        wheel.rotaryImage2 = AudioEffects.image(for: 2)
        wheel.rotaryImage3 = AudioEffects.image(for: 3)
        wheel.rotaryImage4 = AudioEffects.image(for: 4)
        wheel.rotaryImage5 = AudioEffects.image(for: 5)
        wheel.rotaryImage6 = AudioEffects.image(for: 6)
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
