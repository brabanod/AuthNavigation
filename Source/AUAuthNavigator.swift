//
//  AUAuthNavigator.swift
//  LoginOverlays
//
//  Created by Pascal Braband on 30.03.18.
//  Copyright © 2018 Pascal Braband. All rights reserved.
//

import UIKit

public protocol AUAuthenticatable where Self : UIViewController {
    func shouldLogin() -> Bool
    func willReturnFromLoginActions(success: Bool)
}

public class AUAuthNavigator: NSObject {
    
    public static var sharedInstance = AUAuthNavigator()
    
    
    
    // MARK: View Controllers
    
    public var delegate: (UIViewController & AUAuthenticatable)?
    public var loginDelegate: UIViewController?
    public var loadingDelegate: UIViewController?
    
    
    
    // MARK: Segues
    
    public var loginSegueID: String = ""
    public var loadingSegueID: String = ""
    public var loginUnwindSegueID: String = ""
    public var loadingUnwindSegueID: String = ""
    
    
    
    
    
    
    // MARK: - Auth navigation
    
    
    
    private var didStartAuthentication: Bool = false
    
    
    
    public func startAuthentication() {
        if delegate == nil {
            print("ERROR: You've forgotten to set the delegate")
            return
        }
        
        presentOverlay()
        
        // Start process if not already started (because method called within viewWillAppear, it can get called twice -> important to track this)
        if didStartAuthentication == false {
            
            // Check if should present loadingVC
            if didLoginSuccessfully == false {
                
                if loadingSegueID != "" {
                    if didLoad == false {
                        // Calculate if user shouldLogin
                        DispatchQueue.global().async {
                            self.shouldLoginCalculationCache = self.delegate!.shouldLogin()
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
                    if delegate!.shouldLogin() {
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
        
        didStartAuthentication = true
    }
    
    
    
    public func stopAuthentication() {
        didStartAuthentication = false
        dismissOverlay(animated: false)
    }
    
    
    
    
    
    
    // MARK: - Login
    
    
    
    /**
     When a loading screen is used, the result of the shouldLogin method will be saved in this variable
     */
    private var shouldLoginCalculationCache: Bool = true
    
    /**
     Indicates whether user is logged in after returning from login screen
     */
    private var didLoginSuccessfully: Bool = false
    
    
    
    private func presentLoginVC() {
        
        if loginSegueID == "" {
            print("ERROR: Specify loginSegueID in order to show a login view controller.")
        }
            
        else {
            self.presentOverlay()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.001, execute: {
                self.delegate?.performSegue(withIdentifier: self.loginSegueID, sender: self.delegate)
            })
        }
    }
    
    
    
    private func willReturnFromLogin(success: Bool) {
        didLoginSuccessfully = success
        delegate?.willReturnFromLoginActions(success: success)
    }
    
    
    
    public func finishLogin(success: Bool) {
        if loginUnwindSegueID == "" {
            print("ERROR: Specify loginUnwindSegueID in order to perform unwind segue.")
        } else {
            willReturnFromLogin(success: success)
            loginDelegate?.performSegue(withIdentifier: loginUnwindSegueID, sender: loginDelegate)
        }
    }
    
    
    
    
    
    
    // MARK: - Loading
    
    
    
    /**
     Indicates whether loading screen has already been presented
     */
    private var didLoad = false
    
    
    
    private func presentLoadingVC() {
        
        if loadingSegueID == "" {
            print("ERROR: Specify loadingSegueID in order to show a login view controller.")
        }

        else {
            self.presentOverlay()
            
            // Present loading screen
            // Present LoadingVC and remove overlay (after tiny delay to prevent "unbalanced call")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.001, execute: {
                self.delegate?.performSegue(withIdentifier: self.loadingSegueID, sender: self.delegate)
            })
        }
    }
    
    
    
    private func willReturnFromLoading() {
        didLoad = true
    }
    
    
    
    public func finishLoading() {
        if loadingUnwindSegueID == "" {
            print("ERROR: Specify loadingUnwindSegueID in order to perform unwind segue.")
        } else {
            willReturnFromLoading()
            loadingDelegate?.performSegue(withIdentifier: loadingUnwindSegueID, sender: loadingDelegate)
        }
    }
    
    
    
    
    
    
    // MARK: - Overlay
    
    
    
    public var overlayColor: UIColor?
    
    
    private var overlayView: UIView?
    
    
    /**
     Create a customized overlay view which is used to hide the content area before login screen can be presented.
     
     - Important:
     Override this function if you want to customize the overlay view
     
     Remember to set the correct size for the view if you override this method
     
     - returns:
     A UIView object which is used as the overlay
     */
    private func getOverlayView() -> UIView {
        let overlay = UIView(frame: delegate?.view.bounds ?? CGRect.zero)
        
        if overlayColor != nil {
            overlay.backgroundColor = overlayColor
        } else {
            // Default color is the host vc's background color, or white if not existent
            overlay.backgroundColor = delegate?.view.backgroundColor ?? .white
        }
        
        return overlay
    }
    
    
    
    /**
     Present overlayView to hide possible content that shouldn't be shown before login screen can popup.
     */
    private func presentOverlay() {
        
        // Add if not already in view
        if overlayView == nil {
            overlayView = getOverlayView()
            
            if overlayView!.superview == nil {
                delegate?.view.addSubview(overlayView!)
            }
        }
        
        // Present overlay
        overlayView!.isHidden = false
    }
    
    
    
    private func dismissOverlay(animated: Bool) {
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

}
