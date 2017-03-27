//
//  BasicAudioRecorder.swift
//  PitchPerfect
//
//  Created by Shobhit Gupta on 27/03/17.
//  Copyright © 2017 Shobhit Gupta. All rights reserved.
//

import Foundation
import AVFoundation


class BasicAudioRecorder: NSObject {
    
    fileprivate var audioRecorder: AVAudioRecorder?
    fileprivate var session: AVAudioSession?

    
    public func record(sender: ExtendedAVAudioRecorderDelegate) throws {
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
    
    
    public func stop() {
        guard let audioRecorder = audioRecorder, audioRecorder.isRecording else {
            print("BasicAudioRecorder: Trying to stop a recording when no recording is in progress.")
            return
        }
        
        audioRecorder.stop()
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setActive(false)
        } catch {
            debugPrint("BasicAudioRecorder: Failed to make the session inactive.")
            return
        }
    }
    
    
    internal func prepareSession() throws {
        if session == nil {
            session = AVAudioSession.sharedInstance()
        }
        try session?.setCategory(AVAudioSessionCategoryPlayAndRecord)
        guard session?.recordPermission() != .denied else {
            throw Error_.AudioRecorder.permissionDenied
        }
    }
    
    
    internal func prepareForRecording(sender: ExtendedAVAudioRecorderDelegate) throws {
        guard audioRecorder == nil || !audioRecorder!.isRecording else {
            throw Error_.AudioRecorder.occupied
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



extension Error_ {
    
    enum AudioRecorder: Error {
        case occupied
        case permissionDenied
        
        var localizedDescription: String {
            var description = "BasicAudioRecorder Error: "
            switch self {
            case .occupied:
                description += "Cannot initiate a new recording while a previous recording is in progress."
            case .permissionDenied:
                description += "Grant permission to use microphone in Settings > Privacy > Microphone."
            }
            return description
        }
    }
}

