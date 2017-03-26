//
//  AudioManipulator.swift
//  PitchPerfect
//
//  Created by Shobhit Gupta on 24/03/17.
//  Copyright © 2017 Shobhit Gupta. All rights reserved.
//

import Foundation
import AVFoundation


class AudioManipulator: NSObject {
    
    static let shared = AudioManipulator()
    public var currentRecording: URL?
    
    fileprivate var audioRecorder: AVAudioRecorder?
    
    private override init() {
        super.init()
    }
    
}


extension AudioManipulator {
    
    func recordAudio(sender: ExtendedAVAudioRecorderDelegate) throws {
        
        guard audioRecorder == nil || !audioRecorder!.isRecording else {
            throw AppError.AudioManipulator.recorderOccupied
        }
        
        let recordingURL = try FileManager.default.createPathForFile(withExtension: Constants.Recording.FileExtension,
                                                                     relativeTo: Constants.Recording.DataContainerDirectory,
                                                                     at: Constants.Recording.Folder,
                                                                     domainMask: Constants.Recording.DomainMask)
        
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch {
            debugPrint("AudioManipulator: Failed AVAudio")
            return
        }
        
        guard session.recordPermission() != .denied else {
            throw AppError.AudioManipulator.recordPermissionDenied
        }
        
        self.audioRecorder = try AVAudioRecorder(url: recordingURL, settings: [:])
        self.audioRecorder?.delegate = sender
        self.audioRecorder?.isMeteringEnabled = true
        self.audioRecorder?.prepareToRecord()
        
        session.requestRecordPermission() { (granted) in
            if granted {
                self.audioRecorder?.record()
                if let audioRecorder = self.audioRecorder {
                    sender.audioRecorderDidBeginRecording(audioRecorder)
                }
            }
        }
                
    }
    
    
    func stopRecording() {
        guard let audioRecorder = audioRecorder, audioRecorder.isRecording else {
            print("AudioManipulator: Trying to stop a recording when no recording is in progress.")
            return
        }
        
        audioRecorder.stop()
        currentRecording = audioRecorder.url
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setActive(false)
        } catch {
            debugPrint("AudioManipulator: Failed to make the session inactive.")
            return
        }
        
        // self.audioRecorder = nil
    }
    
    
    
    
}








