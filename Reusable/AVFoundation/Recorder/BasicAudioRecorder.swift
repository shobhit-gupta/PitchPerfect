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
    
    
    deinit {
        stop()
    }
    
    
    public func record(sender: ExtendedAVAudioRecorderDelegate) throws {
        try prepareSession(for: AVAudioSessionCategoryPlayAndRecord)
        try prepareForRecording(sender: sender)
        
        session.requestRecordPermission { (granted) in
            if granted {
                if let audioRecorder = self.audioRecorder {
                    audioRecorder.record()
                    if let delegate = audioRecorder.delegate as? ExtendedAVAudioRecorderDelegate {
                        DispatchQueue.main.async {
                            delegate.audioRecorderDidBeginRecording(audioRecorder)
                        }
                    }
                }
            } else {
                self.breakSession()
            }
        }
        
    }
    
    
    public func stop() {
        if let audioRecorder = audioRecorder, audioRecorder.isRecording {
            audioRecorder.stop()
        }
        
        breakSession()
    }
    
    
    private func prepareForRecording(sender: ExtendedAVAudioRecorderDelegate) throws {
        guard audioRecorder == nil || !audioRecorder!.isRecording else {
            throw Error_.Audio.Recorder.occupied
        }
        let recordingURL = try FileManager.default.createPathForFile(withExtension: Constant.Audio.Recording.FileExtension,
                                                                     relativeTo: Constant.Audio.Recording.DataContainerDirectory,
                                                                     at: Constant.Audio.Recording.Folder,
                                                                     domainMask: Constant.Audio.Recording.DomainMask)
        audioRecorder = try AVAudioRecorder(url: recordingURL, settings: [:])
        audioRecorder!.delegate = sender
        audioRecorder!.isMeteringEnabled = true
        audioRecorder!.prepareToRecord()
    }
    
}


extension BasicAudioRecorder: BasicAudioModelProtocol {
    
    func subscribeToAVAudioSessionNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(visible2ObjC(_:)), name: .AVAudioSessionInterruption, object: nil)
    }
    
    // Just a wrapper that is visible to objective C.
    func visible2ObjC(_ notification: Notification) {
        interruption(notification)
    }
    
    
    func unSubscribeFromAVAudioSessionNotifications() {
        NotificationCenter.default.removeObserver(self, name: .AVAudioSessionInterruption, object: nil)
    }
    
    
    func interruptionBegan() {
        stop()
    }
    
    
    func interruptionEnded() {}
    
}


public extension Constant.Audio {
    
    enum Recording {
        static let DataContainerDirectory: FileManager.SearchPathDirectory = .documentDirectory
        static let DomainMask: FileManager.SearchPathDomainMask = .userDomainMask
        static let Folder = "Recordings"
        static let FileExtension = "wav"
    }
    
}


public extension Error_.Audio {
    
    enum Recorder: Error {
        case occupied
        case permissionDenied
        
        var localizedDescription: String {
            var description = String(describing: self)
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

