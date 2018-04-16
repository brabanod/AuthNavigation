//
//  SecretsViewController.swift
//  AuthDemo
//
//  Created by Pascal Braband on 16.04.18.
//  Copyright © 2018 Pascal Braband. All rights reserved.
//

import UIKit

class SecretsViewController: UIViewController, AUAuthenticatable {
    
    @IBOutlet weak var secretView: UIView!
    @IBOutlet weak var authenticateAgainButton: UIButton!
    
    // Change the value to true to see what happens, when user does not need to login
    var isLoggedIn: Bool = false
    
    
    
    
    static let authNavigator = AUAuthNavigator()

    override func viewDidLoad() {
        super.viewDidLoad()

        SecretsViewController.authNavigator.delegate = self
        
        // If you don't specify a hostView, the whole view of MainVC will be covered by authorization (try it)
        SecretsViewController.authNavigator.hostView = secretView
        
        SecretsViewController.authNavigator.loadingVCId = "SecretsLoadingVC"
        SecretsViewController.authNavigator.loginVCId = "SecretsLoginVC"
        
        
        // Disable authenticateAgain button if user is already logged out
        if !isLoggedIn {
            authenticateAgainButton.isEnabled = false
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        SecretsViewController.authNavigator.startAuthentication()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        SecretsViewController.authNavigator.stopAuthentication()
    }
    
    
    
    
    @IBAction func authenticateAgain(_ sender: Any) {
        authenticateAgainButton.isEnabled = false
        SecretsViewController.authNavigator.logout(presentLoading: true)
    }
    
    
    
    
    // MARK: - Authentication
    
    func shouldLogin() -> Bool {
        print("Secrets Authentication started in background")
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
        authenticateAgainButton.isEnabled = true
    }

}
