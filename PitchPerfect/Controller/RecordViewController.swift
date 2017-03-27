//
//  RecordViewController.swift
//  PitchPerfect
//
//  Created by Shobhit Gupta on 20/03/17.
//  Copyright © 2017 Shobhit Gupta. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController {
    
    enum State {
        case recording
        case notRecording(didFinishRecording: Bool)
    }
    
    @IBOutlet weak var microphoneButton: ArtKitButton!
    @IBOutlet weak var waveform: AnimatedWaveform!
    
    var currentState: State = .notRecording(didFinishRecording: false) {
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
            microphoneButton.kind = .microphone(blendMode: .overlay)
        
        case .notRecording(let didFinishRecording):
            waveform.end() { (finished) in
                self.microphoneButton.kind = .microphone(blendMode: .normal)
                if didFinishRecording {
                    self.performSegue(withIdentifier: "showAudioEffects", sender: self)
                }
            }
        }
    }
    
    
    @IBAction func pressed(_ sender: ArtKitButton) {
        switch currentState {
        case .recording:
            AudioManipulator.shared.stopRecording()
 
        case .notRecording:
            do {
                try AudioManipulator.shared.recordAudio(sender: self)
            } catch Error_.AudioManipulator.recorderOccupied {
                print(Error_.AudioManipulator.recorderOccupied.localizedDescription)
                return
            } catch Error_.AudioManipulator.recordPermissionDenied {
                print(Error_.AudioManipulator.recordPermissionDenied.localizedDescription)
                return
            } catch {
                print(error.localizedDescription)
                return
            }
        }
    }
    
}


/*******************************************************************************
                                Initial Setup
 ******************************************************************************/
extension RecordViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return Constant.StatusBarStyle.RecordViewController
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
        microphoneButton.kind = .microphone(blendMode: .normal)
        microphoneButton.backgroundColor = ArtKit.primaryColor
    }
    
    
    func setupWaveform() {
        waveform.frequency = view.frame.width / 100.0
        waveform.waveColor = ArtKit.shadowOfSecondaryColor
        waveform.shouldHideWhenNotAnimating = true
    }
    
}


extension RecordViewController: ExtendedAVAudioRecorderDelegate {
    
    func audioRecorderDidBeginRecording(_ recorder: AVAudioRecorder) {
        currentState = .recording
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            currentState = .notRecording(didFinishRecording: true)
            debugPrint("RecordViewController: Recording successful: \(recorder.url)")
        } else {
            currentState = .notRecording(didFinishRecording: false)
            debugPrint("RecordViewController: Recording failed")
        }
    }
    
}

