//
//  TUIViewControllerExtension.swift
//  dotabuff
//
//  Created by Tri Vo on 6/24/16.
//  Copyright © 2016 acumen. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore


extension UIViewController {
    func setViewControllerTitle(_ title : String, font : UIFont) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : font,
                                                                        NSForegroundColorAttributeName : UIColor.white]
        
        self.title = title
    }
    
    func showAlert(_ title : String, message : String, delegate : AnyObject?, tag : Int, cancelButton: String, ok : String, okHandler:@escaping () -> (), cancelhandler:@escaping () -> ()) {
        let alertContronoller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if cancelButton.length > 0 {
            let alertAction = UIAlertAction(title: cancelButton, style: .cancel, handler: { (action) in
                cancelhandler()
            })
            
            alertContronoller.addAction(alertAction)
        }
        
        if ok.length > 0 {
            let alertAction = UIAlertAction(title: ok, style: .default, handler: { (action) in
                okHandler()
            })
            
            alertContronoller.addAction(alertAction)
        }
        
        let appDelegate = AppDelegate.originDelegate
        appDelegate?.window?.rootViewController?.present(alertContronoller, animated: true, completion: nil)
    }
    
    /**
     Show error alert
     
     - parameter errorMsg:      Error Msg
     - parameter delegate:      Delegate
     - parameter tag:           Tag
     - parameter cancelTitle:   Cancel title
     - parameter okTitle:       Ok Title
     - parameter cancelHandler: Cancel handler
     - parameter okHandler:     Ok handler
     */
    func showErrorAlert(message errorMsg : String, delegate : AnyObject?, tag : Int, cancelTitle : String, okTitle : String = "",
                        cancelHandler : (() -> ())?,
                        okHandler : (() -> ())?) {
        showAlert("Error", message: errorMsg, delegate: delegate, tag: tag, cancelButton: cancelTitle, ok: okTitle, okHandler: {
            okHandler?()
        }) {
            cancelHandler?()
        }
    }
    
    /**
     Show no internet alert
     */
    func showNoInternetAlert() {
        let appDelegate = AppDelegate.originDelegate
        
        self.showAlert("Error", message: "The internet connection appears to be offline. Please check your network and try again.", delegate: nil, tag: 0, cancelButton: "OK", ok: "", okHandler: {
            appDelegate?.window?.rootViewController?.dismiss(animated: true, completion: nil)
        }) {
            appDelegate?.window?.rootViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    /**
     Set back button with title
     
     - parameter title: Title
     */
    func setBackButtonWithTitle(_ title : String) {
        
        let btnBack = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = btnBack
    }
    
    
    /// Get current top view controller
    var currentTopViewController:UIViewController?{
        
        let base = UIApplication.shared.keyWindow?.rootViewController
        
        if let nav = base as? UINavigationController {
            return nav.visibleViewController
        }
        
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return selected
            }
        }
        
        if let presented = base?.presentedViewController {
            return presented
        }
        
        return base
    }
}
