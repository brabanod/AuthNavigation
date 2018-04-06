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
    
    
    
    @IBOutlet weak var mainContentView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        authNavigator.delegate = self
        
        // If you don't specify a hostView, the whole view of MainVC will be covered by authorization (try it)
        authNavigator.hostView = mainContentView
        
        authNavigator.loginVCId = "LoginVC"
        authNavigator.loadingVCId = "LoadingVC"
        
        // Additional parameters you can adjust
        //authNavigator.overlayColor = .blue
        //authNavigator.animationDuration = 0.1
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
        print("Authentication started in background")
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

