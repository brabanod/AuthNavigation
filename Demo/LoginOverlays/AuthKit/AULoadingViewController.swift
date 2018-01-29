//
//  AULoadingViewController.swift
//  LoginOverlays
//
//  Created by Pascal Braband on 27.01.18.
//  Copyright © 2018 Pascal Braband. All rights reserved.
//

import UIKit

class AULoadingViewController: AUBaseViewController {

    
    
    var delegate: AUAuthenticatableViewController?
    
    
    
    func finishLoading() {
        delegate?.willReturnFromLoading()
        self.performSegue(withIdentifier: "AULoadingUnwind", sender: self)
    }

}
