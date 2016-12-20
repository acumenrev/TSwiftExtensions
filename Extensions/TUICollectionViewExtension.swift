//
//  TUICollectionViewExtension.swift
//  
//
//  Created by Tri Vo on 12/20/16.
//
//

import Foundation
import UIKit

extension UICollectionView {
    /**
     Register cell nib
     
     - parameter cellClass: Cell class
     */
    func registerCellNib(_ cellClass: AnyClass) {
        let identifier = String.className(cellClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    /**
     Register cell nib with alternative identifier
     
     - parameter cellClass:             Cell class
     - parameter alternativeIdentifier: Alternative identifier
     */
    func registerCellNib(_ cellClass : AnyClass, alternativeIdentifier : String) {
        let identifier = String.className(cellClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: alternativeIdentifier)
    }
}
