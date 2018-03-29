//
//  AUAuthenticatableViewController.swift
//  LoginOverlays
//
//  Created by Pascal Braband on 13.01.18.
//  Copyright © 2018 Pascal Braband. All rights reserved.
//

import UIKit

class AUAuthenticatableViewController: AUBaseViewController {
    
    var viewWillAppearCalled = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presentOverlay()
        
        // Only call once (becuase viewWillAppear may get called more than once)
        if viewWillAppearCalled == false {
            
            // Check if should present loadingVC
            if isLoggedIn == false {
                
                if loadingSegueID != nil && loadingSegueID != "" {
                    if didLoad == false {
                        // Calculate if user shouldLogin
                        DispatchQueue.global().async {
                            self.shouldLoginCalculationCache = self.shouldLogin()
                        }
                        presentLoadingVC()
                    }
                        
                    // PresentLoginVC
                    else if shouldLoginCalculationCache == true {
                        presentLoginVC()
                    }
                        
                    // Continue to normal view
                    else {
                        dismissOverlay(animated: true)
                    }
                }
                
                // No LoadingVC -> Check if should login
                else {
                    if shouldLogin() {
                        presentLoginVC()
                    }
                        
                    // Continue to normal view
                    else {
                        dismissOverlay(animated: true)
                    }
                }
            } else {
                dismissOverlay(animated: true)
            }
        } else {
            dismissOverlay(animated: true)
        }
        
        viewWillAppearCalled = true
    }
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewWillAppearCalled = false
        
        self.dismissOverlay(animated: false)
    }
    
    
    
    
    
    
    // MARK: - Login method
    
    
    
    private var shouldLoginCalculationCache: Bool = true
    
    private var isLoggedIn: Bool = false
    
    
    /**
     Method is used to determine whether the login screen should be presented or not.
     
     - Important:
     Override this function
     
     - returns:
     A boolean variable indicating the above.
    */
    func shouldLogin() -> Bool {
        return false
    }
    
    
    
    
    
    
    // MARK: - Animation
    
    
    
    /**
     Set this to the StoryboardID of your login view controller.
     */
    var loginSegueID: String?
    
 
    private func presentLoginVC() {
        
        if loginSegueID == nil || loginSegueID == "" {
            print("ERROR: Specify loginVCSegueID in order to show a login view controller.")
        }
        
        else {
            self.presentOverlay()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.001, execute: {
                self.performSegue(withIdentifier: self.loginSegueID!, sender: self)
            })
        }
    }
    
    
    
    /**
     If you need some time to calculate whether user should login or not (e.g. if you need to request a server) then you can use the loading screen to bridge this time.
     If you specify this variable, the loading screen will be presented automatically
     */
    var loadingSegueID: String?
    
    
    var didLoad = false
    
    
    private func presentLoadingVC() {
        
        if loadingSegueID != nil || loadingSegueID != "" {
            
            self.presentOverlay()
            
            // Present loading screen
            // Present LoadingVC and remove overlay (after tiny delay to prevent "unbalanced call")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.001, execute: {
                self.performSegue(withIdentifier: self.loadingSegueID!, sender: self)
            })
        }
    }
    
    
    
    
    
    
    // MARK: - Overlay
    
    
    
    private var overlayView: UIView?
    
    
    /**
     Create a customized overlay view which is used to hide the content area before login screen can be presented.
     
     - Important:
     Override this function if you want to customize the overlay view
     
     Remember to set the correct size for the view if you override this method
     
     - returns:
     A UIView object which is used as the overlay
     */
    func getOverlayView() -> UIView {
        let overlay = UIView(frame: self.view.bounds)
        overlay.backgroundColor = .white
        return overlay
    }
    
    
    
    /**
     Present overlayView to hide possible content that shouldn't be shown before login screen can popup.
    */
    func presentOverlay() {
        
        // Add if not already in view
        if overlayView == nil {
            overlayView = getOverlayView()
            
            if overlayView!.superview == nil {
                self.view.addSubview(overlayView!)
            }
        }
        
        // Present overlay
        overlayView!.isHidden = false
    }
    
    
    
    func dismissOverlay(animated: Bool) {
        if overlayView != nil {
            if animated {
                UIView.animate(withDuration: 0.3, animations: {
                    self.overlayView!.alpha = 0.0
                }, completion: { (success) in
                    self.overlayView!.isHidden = true
                })
            } else {
                overlayView!.isHidden = true
            }
        }
    }
    
    
    
    
    
    
    // MARK: - Segue methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == loginSegueID {
            if let loginVC = segue.destination as? AULoginViewController {
                loginVC.delegate = self
            } else {
                print("ERROR: The login view controller must be a subclass of AULoginViewController")
            }
        }
        
        else if segue.identifier == loadingSegueID {
            if let loadingVC = segue.destination as? AULoadingViewController {
                loadingVC.delegate = self
            } else {
                print("ERROR: The loading view controller must be a subclass of AULoadingViewController")
            }
        }
    }
    
    
    
    
    
    
    // MARK: - Return methods
    
    
    
    /**
     Override this function if you want to perform any actions after successfully loging in.
     
     - Important:
     Don't override the function willReturnFromLogin(success:) if you need to perform additional actions
    */
    func willReturnFromLoginActions() {
        
    }
    
    
    
    final func willReturnFromLogin(success: Bool) {
        isLoggedIn = success
        willReturnFromLoginActions()
    }
    
    
    
    final func willReturnFromLoading() {
        didLoad = true
    }

}
