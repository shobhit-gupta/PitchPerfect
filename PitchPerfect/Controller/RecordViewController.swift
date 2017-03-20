//
//  RecordViewController.swift
//  PitchPerfect
//
//  Created by Shobhit Gupta on 20/03/17.
//  Copyright © 2017 Shobhit Gupta. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController {
    
    @IBOutlet weak var microphoneView: OverlayButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ArtKit.primaryColor
        microphoneView.backgroundColor = ArtKit.primaryColor
    }
    
    
    @IBAction func pressed(_ sender: OverlayButton) {
        sender.currentState = sender.currentState == .normal ? .overlay : .normal
    }

}
