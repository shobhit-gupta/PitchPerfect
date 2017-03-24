//
//  RecordViewController.swift
//  PitchPerfect
//
//  Created by Shobhit Gupta on 20/03/17.
//  Copyright © 2017 Shobhit Gupta. All rights reserved.
//

import UIKit


class RecordViewController: UIViewController {
    
    enum State {
        case recording
        case notRecording
    }
    
    @IBOutlet weak var microphoneButton: ArtKitButton!
    @IBOutlet weak var waveform: AnimatedWaveform!
    
    var currentState: State = .notRecording {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    override func viewDidLayoutSubviews() {
        setupWaveform()
        waveform.setNeedsDisplay()
    }

    
    func updateUI() {
        switch currentState {
        case .recording:
            waveform.begin()
            microphoneButton.currentState = .overlay
        case .notRecording:
            waveform.end() { (finished) in
                self.microphoneButton.currentState = .normal
                self.performSegue(withIdentifier: "showAudioEffects", sender: self)
            }
        }
    }
    
    
    @IBAction func pressed(_ sender: ArtKitButton) {
        switch currentState {
        case .recording:
            currentState = .notRecording
        case .notRecording:
            currentState = .recording
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
        setupWaveform()
    }
    
    
    func setupView() {
        view.backgroundColor = ArtKit.primaryColor
    }
    
    
    func setupMicrophoneButton() {
        microphoneButton.kind = .microphone
        microphoneButton.backgroundColor = ArtKit.primaryColor
    }
    
    
    func setupWaveform() {
        waveform.frequency = view.frame.width / 100.0
        waveform.waveColor = ArtKit.shadowOfSecondaryColor
        waveform.shouldHideWhenNotAnimating = true
    }
    
}
