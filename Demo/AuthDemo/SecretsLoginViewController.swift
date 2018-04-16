//
//  SecretsLoginViewController.swift
//  AuthDemo
//
//  Created by Pascal Braband on 16.04.18.
//  Copyright © 2018 Pascal Braband. All rights reserved.
//

import UIKit

class SecretsLoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var codeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeTextField.delegate = self
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    
    // MARK: - Important part for AuthNavigation
    
    let authNavigator = SecretsViewController.authNavigator

    @IBAction func loginPressed(_ sender: Any) {
        authNavigator.finishLogin(success: true)
    }
}
