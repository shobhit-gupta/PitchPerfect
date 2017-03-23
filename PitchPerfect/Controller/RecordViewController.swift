//
//  RecordViewController.swift
//  PitchPerfect
//
//  Created by Shobhit Gupta on 20/03/17.
//  Copyright © 2017 Shobhit Gupta. All rights reserved.
//

import UIKit
import SwiftSiriWaveformView

class RecordViewController: UIViewController {
    
    @IBOutlet weak var microphoneButton: ArtKitButton!
    @IBOutlet weak var waveform: SwiftSiriWaveformView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    @IBAction func pressed(_ sender: ArtKitButton) {
        sender.currentState = sender.currentState == .normal ? .overlay : .normal
        if sender.currentState == .normal {
            performSegue(withIdentifier: "showAudioEffects", sender: self)
        }
    }

}

extension RecordViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    func setupUI() {
        setupView()
        setupMicrophoneButton()
    }
    
    
    func setupView() {
        view.backgroundColor = ArtKit.primaryColor
    }
    
    
    func setupMicrophoneButton() {
        microphoneButton.kind = .microphone
        microphoneButton.backgroundColor = ArtKit.primaryColor
    }
    
    
    func setupWaveform() {
        
    }
    
}
