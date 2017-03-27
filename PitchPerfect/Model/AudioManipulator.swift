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
    fileprivate var session: AVAudioSession?
    
    private override init() {
        super.init()
    }
    
}


// Mark: Recording
extension AudioManipulator {
    
    public func recordAudio(sender: ExtendedAVAudioRecorderDelegate) throws {
        try prepareSession()
        try prepareForRecording(sender: sender)
        
        session!.requestRecordPermission() { (granted) in
            if granted {
                if let audioRecorder = self.audioRecorder {
                    audioRecorder.record()
                    sender.audioRecorderDidBeginRecording(audioRecorder)
                }
            }
        }
                
    }
    
    
    public func stopRecording() {
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
    
    
    internal func prepareSession() throws {
        if session == nil {
            session = AVAudioSession.sharedInstance()
        }
        try session?.setCategory(AVAudioSessionCategoryPlayAndRecord)
        guard session?.recordPermission() != .denied else {
            throw Error_.AudioManipulator.recordPermissionDenied
        }
    }
    
    
    internal func prepareForRecording(sender: ExtendedAVAudioRecorderDelegate) throws {
        guard audioRecorder == nil || !audioRecorder!.isRecording else {
            throw Error_.AudioManipulator.recorderOccupied
        }
        let recordingURL = try FileManager.default.createPathForFile(withExtension: Constant.Recording.FileExtension,
                                                                     relativeTo: Constant.Recording.DataContainerDirectory,
                                                                     at: Constant.Recording.Folder,
                                                                     domainMask: Constant.Recording.DomainMask)
        audioRecorder = try AVAudioRecorder(url: recordingURL, settings: [:])
        audioRecorder!.delegate = sender
        audioRecorder!.isMeteringEnabled = true
        audioRecorder!.prepareToRecord()
    }
    
}


// Mark: Playing
extension AudioManipulator {
    
}







