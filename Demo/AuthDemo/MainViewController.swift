//
//  MainViewController.swift
//  LoginOverlays
//
//  Created by Pascal Braband on 13.01.18.
//  Copyright © 2018 Pascal Braband. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, AUAuthenticatable {
    
    // Change the value to true to see what happens, when user does not need to login
    var isLoggedIn: Bool = false
    
    let authNavigator = AUAuthNavigator.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        authNavigator.delegate = self
        
        authNavigator.loginSegueID = "AUAuthToLogin"
        authNavigator.loginUnwindSegueID = "AULoginUnwind"
        
        // Outcomment the following two lines to see what happens when no loading screen is given
        authNavigator.loadingSegueID = "AUAuthToLoading"
        authNavigator.loadingUnwindSegueID = "AULoadingUnwind"
    }

    override func viewWillAppear(_ animated: Bool) {
        authNavigator.startAuthentication()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        authNavigator.stopAuthentication()
    }
    
    @IBAction func returnFromSegueActions(sender: UIStoryboardSegue) {
        
    }
    
    
    
    
    
    // MARK: - Authentication
    
    func shouldLogin() -> Bool {
        print("ongoing authentication")
        if isLoggedIn {
            return false
        } else {
            return true
        }
    }
    
    
    
    func willReturnFromLoginActions(success: Bool) {
        // This is only done, to simulate login. Because there is no backend,
        // login status is saved locally in a variable
        isLoggedIn = true
    }


}

