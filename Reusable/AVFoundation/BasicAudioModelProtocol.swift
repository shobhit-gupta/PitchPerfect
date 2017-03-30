//
//  BasicAudioModelProtocol.swift
//  PitchPerfect
//
//  Created by Shobhit Gupta on 30/03/17.
//  Copyright © 2017 Shobhit Gupta. All rights reserved.
//

import Foundation
import AVFoundation


public protocol BasicAudioModelProtocol {
    // Session
    var session: AVAudioSession { get }
    func prepareSession(for category: String) throws
    func breakSession()
    
    // Interruptions
    func subscribeToAVAudioSessionNotifications()
    func unSubscribeFromAVAudioSessionNotifications()
    func interruption(_ notification: Notification)
    func interruptionBegan()
    func interruptionEnded()
    
}


public extension BasicAudioModelProtocol {
    
    var session: AVAudioSession {
        return AVAudioSession.sharedInstance()
    }
    
    
    func prepareSession(for category: String) throws {
        try session.setCategory(category)
        try session.setActive(true)
        if category == AVAudioSessionCategoryRecord || category == AVAudioSessionCategoryPlayAndRecord {
            guard session.recordPermission() != .denied else {
                throw Error_.Audio.Recorder.permissionDenied
            }
        }
        subscribeToAVAudioSessionNotifications()
    }
    
    
    func breakSession() {
        do {
            try session.setActive(false)
        } catch {
            print(error.info())
            return
        }
        unSubscribeFromAVAudioSessionNotifications()
    }
    
    
    func interruption(_ notification: Notification) {
        if notification.name == .AVAudioSessionInterruption,
            let info = notification.userInfo,
            let type = info[AVAudioSessionInterruptionTypeKey] as? NSNumber {
            
            switch AVAudioSessionInterruptionType(rawValue: type.uintValue)! {
            case .began:
                interruptionBegan()
            case .ended:
                interruptionEnded()
            }
        }
    }
    
}





