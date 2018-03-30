//
//  LoginViewController.swift
//  LoginOverlays
//
//  Created by Pascal Braband on 13.01.18.
//  Copyright © 2018 Pascal Braband. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let authNavigator = AUAuthNavigator.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authNavigator.loginDelegate = self
    }

    @IBAction func pressedLoginButton(_ sender: Any) {
        authNavigator.finishLogin(success: true)
    }
    
}
