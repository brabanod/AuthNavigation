//
//  AULoginViewController.swift
//  LoginOverlays
//
//  Created by Pascal Braband on 13.01.18.
//  Copyright © 2018 Pascal Braband. All rights reserved.
//

import UIKit

class AULoginViewController: AUBaseViewController {
    
    
    
    var delegate: AUAuthenticatableViewController?
    
    
    
    final func finishLogin(success: Bool) {
        delegate?.willReturnFromLogin(success: success)
        self.performSegue(withIdentifier: "AULoginUnwind", sender: self)
    }

}
