//
//  AUSegueFadeUnwind.swift
//  LoginOverlays
//
//  Created by Pascal Braband on 27.01.18.
//  Copyright © 2018 Pascal Braband. All rights reserved.
//

import UIKit

class AUSegueFadeUnwind: UIStoryboardSegue {

    override func perform() {
        
        if !UIView.areAnimationsEnabled {
            print("ERROR: Enable animations for segue in Interface Builder. Check \"Animates\" in Attributes Inspector")
        }
        
        // Add DestinationViewController's view to screen/window
        let window = UIApplication.shared.keyWindow
        destination.view.alpha = 0.0
        window?.insertSubview(destination.view, aboveSubview: source.view)
        
        // Fade animation
        UIView.animate(withDuration: 0.3, animations: {
            self.destination.view.alpha = 1.0
        }, completion: { (success) in
            self.source.dismiss(animated: false, completion: nil)
        })
    }
}
