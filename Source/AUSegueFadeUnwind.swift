//
//  AUSegueFadeUnwind.swift
//  LoginOverlays
//
//  Created by Pascal Braband on 27.01.18.
//  Copyright © 2018 Pascal Braband. All rights reserved.
//

import UIKit

public class AUSegueFadeUnwind: UIStoryboardSegue {

    public override func perform() {
        
        if !UIView.areAnimationsEnabled {
            print("ERROR: Enable animations for segue in Interface Builder. Check \"Animates\" in Attributes Inspector")
        }
        
        // Add DestinationViewController's view below current displaying view
        let whiteView = UIView(frame: source.view.frame)
        whiteView.backgroundColor = .white
        source.view.superview?.insertSubview(whiteView, belowSubview: source.view)
        
        // Fade animation
        UIView.animate(withDuration: 0.3, animations: {
            self.source.view.alpha = 0.0
        }, completion: { (success) in
            self.source.dismiss(animated: false, completion: nil)
        })
    }
}
