//
//  AudioEffectsViewController.swift
//  PitchPerfect
//
//  Created by Shobhit Gupta on 20/03/17.
//  Copyright © 2017 Shobhit Gupta. All rights reserved.
//

import UIKit
import HCRotaryWheel


class AudioEffectsViewController: CustomTraitCollectionViewController {

    @IBOutlet weak var wheel: RotaryWheel!
    @IBOutlet weak var closeButton: ArtKitButton!
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.kind = .close
        closeButton.backgroundColor = ArtKit.primaryColor
        view.backgroundColor = ArtKit.primaryColor
        setupWheel()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @IBAction func close(_ sender: ArtKitButton) {
        print("View size: \(view.frame.size)")
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLayoutSubviews() {
        wheel.redraw()
    }
}


extension AudioEffectsViewController: RotaryProtocol {
    
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
    
    
    func wheelDidChangeValue(_ currentSector: Int32) {
        
    }
    
}
