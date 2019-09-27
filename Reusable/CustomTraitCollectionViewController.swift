//
//  CustomTraitCollectionViewController.swift
//  PitchPerfect
//
//  Created by Shobhit Gupta on 22/03/17.
//  Copyright © 2017 Shobhit Gupta. All rights reserved.
//
//  Change default size classes set by Apple to better meet the project needs.
//  

import UIKit


open class CustomTraitCollectionViewController: UIViewController {

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    open override var traitCollection: UITraitCollection {
        
        // Change default size class for iPad set by Apple.
        if UI_USER_INTERFACE_IDIOM() == .pad {
        
            let collections: [UITraitCollection]
            
            if view.bounds.width > view.bounds.height {
                collections = [UITraitCollection(horizontalSizeClass: Constant.SizeClass.Pad.GreaterWidth.Horizontal),
                               UITraitCollection(verticalSizeClass: Constant.SizeClass.Pad.GreaterWidth.Vertical)]
            
            } else if view.bounds.height > view.bounds.width {
                collections = [UITraitCollection(horizontalSizeClass: Constant.SizeClass.Pad.GreaterHeight.Horizontal),
                               UITraitCollection(verticalSizeClass: Constant.SizeClass.Pad.GreaterHeight.Vertical)]
            
            } else {
                collections = [UITraitCollection(horizontalSizeClass: Constant.SizeClass.Pad.EqualWidthAndHeight.Horizontal),
                               UITraitCollection(verticalSizeClass: Constant.SizeClass.Pad.EqualWidthAndHeight.Vertical)]
            }
            
            return UITraitCollection(traitsFrom: collections)
            
        }
        
        // No change to default size class
        return super.traitCollection
    }

}


public extension Constant {
    
    enum SizeClass {
        
        enum Pad {
        
            enum GreaterWidth {
                static let Horizontal: UIUserInterfaceSizeClass = .regular
                static let Vertical: UIUserInterfaceSizeClass = .compact
            }
            
            enum GreaterHeight {
                static let Horizontal: UIUserInterfaceSizeClass = .compact
                static let Vertical: UIUserInterfaceSizeClass = .regular
            }
            
            enum EqualWidthAndHeight {
                static let Horizontal: UIUserInterfaceSizeClass = .compact
                static let Vertical: UIUserInterfaceSizeClass = .regular
            }
        }
    }
}
