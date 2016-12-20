//
//  UIScreenExtension.swift
//  
//
//  Created by Tri Vo on 12/20/16.
//
//

import Foundation
import UIKit

public extension UIScreen {
    
    /**
     Device size type
     
     - Unknown:     Unknown device
     - iPhone4:     iPhone 4
     - iPhone5:     iPhone 5
     - iPhone6:     iPhone 6
     - iPhone6Plus: iPhone 6 Plus
     */
    enum DeviceSizeType: CGFloat {
        case unknown = 0.0
        case iPhone4 = 960.0
        case iPhone5 = 1136.0
        case iPhone6 = 1334.0
        case iPhone6Plus = 2208.0
    }
    
    /// Check iPhone screen
    ///
    /// - parameter sizeType: Device size
    ///
    /// - returns: Boolean value
    func isIPhone(deviceSize screenSize : DeviceSizeType) -> Bool {
        let height = self.nativeBounds.height
        if height == screenSize.rawValue {
            return true
        }
        
        return false
    }
    
    /// Check whether current screen is equal to 3.5 inch
    var isIPhone4Screen : Bool {
        get {
            return isIPhone(deviceSize: .iPhone4)
        }
    }
    
    /// Check whether current screen is equal to 4 inch
    var isiPhone5Screen : Bool {
        get {
            return isIPhone(deviceSize: .iPhone5)
        }
    }
    
    /// Check whether current screen is equal to 4.7 inch
    var isIPhone6Screen : Bool {
        get {
            return isIPhone(deviceSize: .iPhone6)
        }
    }
    
    /// Check whether current screen is equal to 5.5 inch
    var isIPhone6PlusScreen : Bool {
        get {
            return isIPhone(deviceSize: .iPhone6Plus)
        }
    }
}
