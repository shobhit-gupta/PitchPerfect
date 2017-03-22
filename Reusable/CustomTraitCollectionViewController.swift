//
//  CustomTraitCollectionViewController.swift
//  PitchPerfect
//
//  Created by Shobhit Gupta on 22/03/17.
//  Copyright © 2017 Shobhit Gupta. All rights reserved.
//

import UIKit

public class CustomTraitCollectionViewController: UIViewController {

    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    public override var traitCollection: UITraitCollection {
        if UI_USER_INTERFACE_IDIOM() == .pad {
            
            let collections: [UITraitCollection]
            if view.bounds.width > view.bounds.height {
                collections = [UITraitCollection(horizontalSizeClass: .regular),
                                   UITraitCollection(verticalSizeClass: .compact)]
            } else {
                collections = [UITraitCollection(horizontalSizeClass: .compact),
                               UITraitCollection(verticalSizeClass: .regular)]
            }
            
            return UITraitCollection(traitsFrom: collections)
        }
        
        return super.traitCollection
    }
    

}
