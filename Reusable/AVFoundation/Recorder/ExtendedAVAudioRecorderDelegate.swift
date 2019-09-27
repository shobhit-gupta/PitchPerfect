//
//  AVAudioRecorderDelegate+.swift
//  PitchPerfect
//
//  Created by Shobhit Gupta on 26/03/17.
//  Copyright © 2017 Shobhit Gupta. All rights reserved.
//

import Foundation
import AVFoundation


protocol ExtendedAVAudioRecorderDelegate: AVAudioRecorderDelegate {
    func audioRecorderDidBeginRecording(_ recorder: AVAudioRecorder)
}
