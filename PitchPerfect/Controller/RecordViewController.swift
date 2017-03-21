//
//  RecordViewController.swift
//  PitchPerfect
//
//  Created by Shobhit Gupta on 20/03/17.
//  Copyright © 2017 Shobhit Gupta. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController {
    
    @IBOutlet weak var microphoneView: ArtKitButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ArtKit.primaryColor
        microphoneView.kind = .microphone
        microphoneView.backgroundColor = ArtKit.primaryColor
    }
    
    
    @IBAction func pressed(_ sender: ArtKitButton) {
        sender.currentState = sender.currentState == .normal ? .overlay : .normal
        if sender.currentState == .normal {
            performSegue(withIdentifier: "showAudioEffects", sender: self)
        }
    }

}
