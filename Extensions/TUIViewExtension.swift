//
//  TUIViewExtension.swift
//  
//
//  Created by Tri Vo on 12/20/16.
//
//

import Foundation
import UIKit
import QuartzCore

extension UIView {
    /**
     Fade in a view with a duration
     
     - parameter duration: custom animation duration
     */
    func animateFadeIn(duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }
    
    /**
     Fade out a view with a duration
     
     - parameter duration: custom animation duration
     */
    func animateFadeOut(duration: TimeInterval = 1.0, completion : (() -> ())?) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        }, completion: { completed in
            completion?()
        })
    }
    
    func animatePulse(duration : TimeInterval = 0.25, show isShow : Bool) {
        if isShow {
            self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            self.alpha = 0.0;
            UIView.animate(withDuration: duration, animations: {
                self.alpha = 1.0
                self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            });
        } else {
            UIView.animate(withDuration: 0.25, animations: {
                self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                self.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.removeFromSuperview()
                }
            });
        }
    }
    
    func animateCurlUp(duration : TimeInterval = 1.0) {
        /*
         // create a 'tuple' (a pair or more of objects assigned to a single variable)
         let views = (frontView: self.redSquare, backView: self.blueSquare)
         
         // set a transition style
         let transitionOptions = UIViewAnimationOptions.TransitionCurlUp
         
         UIView.transitionWithView(self.container, duration: 1.0, options: transitionOptions, animations: {
         // remove the front object...
         views.frontView.removeFromSuperview()
         
         // ... and add the other object
         self.container.addSubview(views.backView)
         
         }, completion: { finished in
         // any code entered here will be applied
         // .once the animation has completed
         })
         */
        
    }
    
    func mask(_ viewToMask: UIView, maskRect: CGRect) {
        let maskLayer = CAShapeLayer()
        let path = CGPath(rect: maskRect, transform: nil)
        maskLayer.path = path
        
        // Set the mask of the view.
        viewToMask.layer.mask = maskLayer;
    }
    
    class func loadNib<T: UIView>(_ viewType: T.Type) -> T {
        let className = String.className(viewType)
        return Bundle(for: viewType).loadNibNamed(className, owner: nil, options: nil)!.first as! T
    }
    
    class func loadNib() -> Self {
        return loadNib(self)
    }
    
    func roundon(_ radius : CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
    }
    
    func convertViewToImage() -> UIImage{
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        return image!;
    }
}
