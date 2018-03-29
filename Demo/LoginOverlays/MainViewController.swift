//
//  MainViewController.swift
//  LoginOverlays
//
//  Created by Pascal Braband on 13.01.18.
//  Copyright © 2018 Pascal Braband. All rights reserved.
//

import UIKit

class MainViewController: AUAuthenticatableViewController {
    
    // Change the value to true to see what happens, when user does not need to login
    var isLoggedIn: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loginSegueID = "AUAuthToLogin"
        
        // Outcomment this line to see what happens when no loading screen is given
        loadingSegueID = "AUAuthToLoading"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    // MARK: - Authentication
    
    override func shouldLogin() -> Bool {
        print("ongoing calculation")
        if isLoggedIn {
            return false
        } else {
            return true
        }
    }
    
    
    
    override func willReturnFromLoginActions() {
        isLoggedIn = true
    }


}

