//
//  Error_+App.swift
//  PitchPerfect
//
//  Created by Shobhit Gupta on 26/03/17.
//  Copyright © 2017 Shobhit Gupta. All rights reserved.
//

import Foundation


extension Error_ {
    
    enum AudioManipulator: Error {
        case recorderOccupied
        case recordPermissionDenied
        
        var localizedDescription: String {
            var description = "AudioManipulator Error: "
            switch self {
            case .recorderOccupied:
                description += "Cannot initiate a new recording while a previous recording is in progress."
            case .recordPermissionDenied:
                description += "Grant permission to use microphone in Settings > Privacy > Microphone."
            }
            return description
        }
    }
    
}
