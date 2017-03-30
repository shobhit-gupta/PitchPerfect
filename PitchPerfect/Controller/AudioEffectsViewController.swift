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
    
    // MARK: IBOutlets
    @IBOutlet weak var wheel: RotaryWheel!
    @IBOutlet weak var closeButton: ArtKitButton!
    @IBOutlet weak var circularSliderGradient: CircularSliderGradient!
    @IBOutlet weak var circularSlider: CircularSlider!
    
    
    // MARK: Public variables and types
    public var recording: URL!

    
    // MARK: Private variables and types
    fileprivate var audioPlayer = BasicAudioPlayer()
    
    fileprivate var currentEffect: AudioEffect? {
        // HCRotaryWheel returns currentSector value starting from 0.
        // AudioEffect enum starts from the value of 1.
        // Why does AudioEffect enum start from 1?
        // Because, HCRotary wheel names the rotaryImages from 1, i.e.
        // rotartImage1, rotaryImage2 and so on... See setupWheel() method.
        return AudioEffect(rawValue: Int(wheel.currentSector + 1))
    }
    
    fileprivate var factor: Int {
        return Int(circularSlider.endPointValue)
    }
    
    
    // MARK: ViewController Methods
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

    
    // MARK: IBActions
    @IBAction func close(_ sender: ArtKitButton) {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    func play() {
        if let currentEffect = currentEffect {
            print("Factor: \(factor)")
            do {
                try audioPlayer.play(recording, with: currentEffect.audioProperties(scaledBy: factor))
            } catch let error as Error_.Audio.Property {
                print(error.localizedDescription)
                return
            } catch {
                print(error.info())
                return
            }
        }
    }
    
}


//******************************************************************************
//                              MARK: User Interface
//******************************************************************************
extension AudioEffectsViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return Constant.StatusBarStyle.AudioEffectsViewController
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
        wheel.rotaryImage1 = AudioEffect.image(for: 1)
        wheel.rotaryImage2 = AudioEffect.image(for: 2)
        wheel.rotaryImage3 = AudioEffect.image(for: 3)
        wheel.rotaryImage4 = AudioEffect.image(for: 4)
        wheel.rotaryImage5 = AudioEffect.image(for: 5)
        wheel.rotaryImage6 = AudioEffect.image(for: 6)
        wheel.delegate = self
    }
    
    
    func setupCircularSlider() {
        // Disk
        circularSlider.diskColor = UIColor.clear
        circularSlider.diskFillColor = UIColor.clear
        
        // Track
        circularSlider.trackColor = ArtKit.shadowOfPrimaryColor
        circularSlider.trackFillColor = ArtKit.highlightOfPrimaryColor
        circularSlider.lineWidth = Constant.CircularSlider.LineWidth
        
        // Thumb
        circularSlider.thumbLineWidth = Constant.CircularSlider.ThumbLineWidth
        circularSlider.thumbRadius = Constant.CircularSlider.ThumbRadius
        circularSlider.endThumbTintColor = ArtKit.secondaryColor
        circularSlider.endThumbStrokeColor = ArtKit.secondaryColor
        circularSlider.endThumbStrokeHighlightedColor = ArtKit.secondaryColor
        
        // Values
        circularSlider.minimumValue = CGFloat(Constant.Audio.Effect.Factor.Minimum)
        circularSlider.maximumValue = CGFloat(Constant.Audio.Effect.Factor.Maximum)
        circularSlider.endPointValue = CGFloat(Constant.Audio.Effect.Factor.Default)
        
        //circularSlider.addTarget(self, action: #selector(sliderDidChange), for: .valueChanged)
        circularSlider.addTarget(self, action: #selector(sliderDoneEditing), for: .editingDidEnd)
    }
    
    
    func setupCircularSliderGradient() {
        circularSliderGradient.sync(with: circularSlider)
    }
    
}


//******************************************************************************
//                              MARK: RotaryProtocol
//******************************************************************************
extension AudioEffectsViewController: RotaryProtocol {
    
    func wheelDidChangeValue(_ currentSector: Int32) {
        if wheel.isUserInitiated {
            play()
        }
    }
    
}


//******************************************************************************
//                              MARK: Circular Slider
//******************************************************************************
extension AudioEffectsViewController {
    
    func sliderDoneEditing() {
        let value = round(circularSlider.endPointValue)
        circularSlider.endPointValue = value
        play()
    }
    
}
