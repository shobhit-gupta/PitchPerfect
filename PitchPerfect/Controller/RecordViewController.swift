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
    
    // MARK: IBOutlets
    @IBOutlet weak var microphoneButton: ArtKitButton!
    @IBOutlet weak var waveform: AnimatedWaveform!
    
    // MARK: Private variables and types
    fileprivate enum State {
        case recording
        case notRecording(didFinishRecording: Bool, file: URL?)
    }
    
    fileprivate var currentState: State = .notRecording(didFinishRecording: false, file: nil) {
        didSet {
            updateUI()
        }
    }
    
    fileprivate var audioRecorder: BasicAudioRecorder?
    
    
    // MARK: ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupWaveform()
        waveform.setNeedsDisplay()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.Segue.ShowAudioEffects {
            if let audioEffectsVC = segue.destination as? AudioEffectsViewController {
                audioEffectsVC.recording = sender as! URL
            } else {
                print("RecordViewController: Check segue identifier: \(String(describing: segue.identifier))")
            }
        }
    }
    
    
    // MARK: IBActions
    @IBAction func pressed(_ sender: ArtKitButton) {
        switch currentState {
        case .recording:
            if let audioRecorder = audioRecorder {
                audioRecorder.stop()
            } else {
                print("RecordViewController Warning: audioRecorder not found in recording state!")
            }
 
        case .notRecording:
            audioRecorder = BasicAudioRecorder()
            do {
                try audioRecorder?.record(sender: self)
            } catch let error as Error_.Audio.Recorder {
                print(error.localizedDescription)
                return
            } catch let error as Error_.FileManager_ {
                print(error.localizedDescription)
                return
            }
            catch {
                print(error.info())
                return
            }
        }
    }
    
}


//******************************************************************************
//                              MARK: User Interface
//******************************************************************************
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
    
    
    func updateUI() {
        switch currentState {
        case .recording:
            waveform.begin()
            microphoneButton.kind = .microphone(blendMode: .overlay)
            
        case let .notRecording(didFinishRecording, file):
            if didFinishRecording {
                waveform.end { (finished) in
                    self.microphoneButton.kind = .microphone(blendMode: .normal)
                    if let file = file {
                        self.performSegue(withIdentifier: Constant.Segue.ShowAudioEffects, sender: file)
                    }
                }
            }
            audioRecorder = nil
        }
    }
    
}


//******************************************************************************
//                     MARK: ExtendedAVAudioRecorderDelegate
//******************************************************************************
extension RecordViewController: ExtendedAVAudioRecorderDelegate {
    
    func audioRecorderDidBeginRecording(_ recorder: AVAudioRecorder) {
        currentState = .recording
    }
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            currentState = .notRecording(didFinishRecording: true, file: recorder.url)
//            debugPrint("RecordViewController: Recording successful: \(recorder.url)")
        } else {
            currentState = .notRecording(didFinishRecording: true, file: nil)
            debugPrint("RecordViewController: Recording failed")
        }
    }
    
}

