//
//  AUAuthNavigator.swift
//  AuthNavigation
//
//  Created by Pascal Braband on 05.04.18.
//  Copyright © 2018 Pascal Braband. All rights reserved.
//

import UIKit






public protocol AUAuthenticatable where Self : UIViewController {
    
    
    
    /**
     Implement your authentication process in here
     
     - Important:
     Sometimes this method gets called from a background thread. Make sure that if you do UI changes in this method (which actually should not be the case) do them in the main thread.
     */
    func shouldLogin() -> Bool
    
    
    
    /**
     Here you can execute additional actions when returning from the login, but of course you don't need to.
     */
    func willReturnFromLoginActions(success: Bool)
}









// MARK: -
public class AUAuthNavigator: UIView {
    
    
    
    public static var sharedInstance = AUAuthNavigator()
    
    
    
    /**
     Specify a custom duration for all animations done by AUAuthNavigator (overlay, login and loading fade in/out)
     */
    public var animationDuration: TimeInterval = 0.3
    
    
    
    
    
    
    // MARK: View Controllers
    
    
    
    /**
     The delegate is the host of the authentication, it's the view controller, that needs authentication
     */
    public var delegate: (UIViewController & AUAuthenticatable)?
    
    
    
    /**
     You can specify a host view for your authentication. The login and loading screen (if given) will then only be presented in that host view. By default the host is the entire screen.
     */
    public var hostView: UIView?
    
    
    
    /**
     Set this to be the Storyboard ID of your LoginVC
     */
    public var loginVCId: String?
    
    
    
    /**
     Set this to be the Storyboard ID of your LoadingVC
     */
    public var loadingVCId: String?
    
    
    
    
    
    
    // MARK: - Authentication
    
    
    
    private var isAuthenticationRunning: Bool = false
    
    
    
    /**
     Call this method in viewWillAppear of your HostVC. It will start the authentication process.
     */
    public func startAuthentication() {
        if delegate == nil {
            print("ERROR: You've forgotten to set the delegate")
            return
        }
        
        // Set default authView to delegates view
        if hostView == nil {
            hostView = delegate?.view
        }
        
        presentOverlay()
        
        // Start process if not already started (because method called within viewWillAppear, it can get called twice -> important to track this)
        if isAuthenticationRunning == false {
            isAuthenticationRunning = true
            
            // Check if should present loadingVC
            if didLoginSuccessfully == false {
                
                if loadingVCId != nil {
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
    }
    
    
    
    /**
     Call this method in viewWillDisappear of your HostVC.
     */
    public func stopAuthentication() {
        isAuthenticationRunning = false
        dismissOverlay(animated: false)
    }
    
    
    
    /**
     Call this method if you want to logout. The login screen will be presented.
     
     - parameters:
     - presentLoading: Set this to true if you want to present the loading screen again after logout.
     */
    public func logout(presentLoading: Bool) {
        
        // Reset everything
        didLoginSuccessfully = false
        didLoad = false
        stopAuthentication()
        overlayView = nil
        
        // Either present loading screen or login directly
        if presentLoading {
            presentLoadingVC()
        } else {
            presentLoginVC()
        }
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
    
    
    
    /**
     If the LoadingVC is currently presented, it will be saved in this variable
     */
    private var loginVC: UIViewController?
    
    
    
    private func presentLoginVC() {
        
        if loginVCId == nil || delegate == nil {
            print("ERROR: Specify delegate and loginDelegate in order to show a login view.")
            return
        }
        
        if delegate == nil {
            print("ERROR: Specify delegate in order to show a login view.")
            return
        }
        
        if hostView == nil {
            print("ERROR: authView should not be nil, even if you didn't set it.")
            return
        }
        
        
        self.presentOverlay()
        
        // Add LoginVC into container
        loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: loginVCId!) as UIViewController
        delegate!.addChildViewController(loginVC!)
        
        loginVC!.view.alpha = 0.0
        hostView!.addSubview(loginVC!.view)
        loginVC!.view.frame = hostView!.bounds
        loginVC!.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        loginVC!.didMove(toParentViewController: delegate!)
        
        // Animate fade in
        UIView.animate(withDuration: animationDuration, animations: {
            self.loginVC!.view.alpha = 1.0
        })
        
        // Need to reset didStartAuthentication because after returning from login,
        // startAuthentication should run again
        isAuthenticationRunning = false
    }
    
    
    
    private func willReturnFromLogin(success: Bool) {
        didLoginSuccessfully = success
        delegate?.willReturnFromLoginActions(success: success)
        startAuthentication()
    }
    
    
    
    /**
     Call this method from your LoginVC if the login process is finished
     */
    public func finishLogin(success: Bool) {
        if loginVCId == nil {
            print("ERROR: Cannot return from login if no loginDelegate is given.")
        } else {
            willReturnFromLogin(success: success)
            
            // Animate fade out
            UIView.animate(withDuration: animationDuration, animations: {
                self.loginVC!.view.alpha = 0.0
            }, completion: { (success) in
                // Remove LoginVC from container
                self.loginVC!.view.removeFromSuperview()
                self.loginVC!.removeFromParentViewController()
                self.loginVC = nil
            })
        }
    }
    
    
    
    
    
    
    // MARK: - Loading
    
    
    
    /**
     Indicates whether loading screen has already been presented
     */
    private var didLoad = false
    
    
    /**
     If the LoadingVC is currently presented, it will be saved in this variable
     */
    private var loadingVC: UIViewController?
    
    
    
    private func presentLoadingVC() {
        
        if loadingVCId == nil {
            print("ERROR: Specify loadingDelegate in order to show a loading view.")
        }
        
        if delegate == nil {
            print("ERROR: Specify delegate in order to show a loading view.")
            return
        }
        
        if hostView == nil {
            print("ERROR: authView should not be nil, even if you didn't set it.")
            return
        }
        
        // Add LoginVC into container
        loadingVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: loadingVCId!) as UIViewController
        delegate!.addChildViewController(loadingVC!)
        
        loadingVC!.view.alpha = 0.0
        hostView!.addSubview(loadingVC!.view)
        loadingVC!.view.frame = hostView!.bounds
        loadingVC!.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        loadingVC!.didMove(toParentViewController: delegate!)
        
        // Animate fade in
        UIView.animate(withDuration: animationDuration, animations: {
            self.loadingVC!.view.alpha = 1.0
        })
        
        // Need to reset didStartAuthentication because after returning from loading,
        // startAuthentication should run again
        isAuthenticationRunning = false
    }
    
    
    
    private func willReturnFromLoading() {
        didLoad = true
        startAuthentication()
    }
    
    
    
    /**
     Call this method from your LoginVC if the login process is finished
     */
    public func finishLoading() {
        if loadingVCId == nil {
            print("ERROR: Cannot return from loading if no loadingDelegate is given.")
        } else {
            willReturnFromLoading()
            
            // Animate fade out
            UIView.animate(withDuration: animationDuration, animations: {
                self.loadingVC!.view.alpha = 0.0
            }, completion: { (success) in
                // Remove LoginVC from container
                self.loadingVC!.view.removeFromSuperview()
                self.loadingVC!.removeFromParentViewController()
                self.loadingVC = nil
            })
        }
    }
    
    
    
    
    
    
    // MARK: - Overlay
    
    
    
    /**
     The overlay is used to hide the content of your MainVC during authorization. If you need this overlay to have a special color, then specify it here. Default behaviour is to use the background color of the hostView.
     */
    public var overlayColor: UIColor?
    
    
    private var overlayView: UIView?
    
    
    
    /**
     Creates an overlay view which is used to hide the content area before login screen can be presented.
     
     - Important:
     Override this function if you want to customize the overlay view
     
     Remember to set the correct size for the view if you override this method
     
     - returns:
     A UIView object which is used as the overlay
     */
    private func getOverlayView() -> UIView {
        let overlay = UIView(frame: hostView?.bounds ?? CGRect.zero)
        
        if overlayColor != nil {
            overlay.backgroundColor = overlayColor
        } else {
            // Default color is the host vc's background color, or white if not existent
            overlay.backgroundColor = hostView?.backgroundColor ?? .white
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
            
        }
        
        if overlayView!.superview == nil {
            hostView?.addSubview(overlayView!)
        }
        
        // Present overlay
        overlayView!.isHidden = false
    }
    
    
    
    private func dismissOverlay(animated: Bool) {
        if overlayView != nil {
            if animated {
                UIView.animate(withDuration: animationDuration, animations: {
                    self.overlayView!.alpha = 0.0
                }, completion: { (success) in
                    self.overlayView!.isHidden = true
                })
            } else {
                overlayView!.isHidden = true
            }
            
            self.overlayView!.removeFromSuperview()
        }
    }
    
}

