//
//  SecretsLoadingViewController.swift
//  AuthDemo
//
//  Created by Pascal Braband on 16.04.18.
//  Copyright © 2018 Pascal Braband. All rights reserved.
//

import UIKit

class SecretsLoadingViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    let authNavigator = SecretsViewController.authNavigator
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        // Let activity indicator spin
        activityIndicator.startAnimating()
        
        // Stop after 2 seconds and finish loading
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) {
            self.activityIndicator.stopAnimating()
            self.authNavigator.finishLoading()
        }
    }

}
