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
    
    static let authNavigator = AUAuthNavigator()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MainViewController.authNavigator.delegate = self
        
        MainViewController.authNavigator.loginVCId = "LoginVC"
        MainViewController.authNavigator.loadingVCId = "LoadingVC"
        
        // If you don't specify a hostView, the whole view of MainVC will be covered by authorization
        // MainViewController.authNavigator.hostView = <UIView>
        
        // Additional parameters you can adjust
        //MainViewController.authNavigator.overlayColor = .blue
        //MainViewController.authNavigator.animationDuration = 0.1
    }

    override func viewWillAppear(_ animated: Bool) {
        MainViewController.authNavigator.startAuthentication()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        MainViewController.authNavigator.stopAuthentication()
    }
    
    
    
    
    @IBAction
    func unwindToHome(segue: UIStoryboardSegue) {}
    
    @IBAction func logoutPressed(_ sender: Any) {
        isLoggedIn = false
        MainViewController.authNavigator.logout(presentLoading: false)
    }
    
    
    
    
    // MARK: - Authentication
    
    func shouldLogin() -> Bool {
        print("Main Authentication started in background")
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

