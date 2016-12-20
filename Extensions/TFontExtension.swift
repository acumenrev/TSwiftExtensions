//
//  TFontExtension.swift
//  
//
//  Created by Tri Vo on 12/20/16.
//
//

import Foundation
import UIKit

extension UIFont {
    
    func withTraits(traits:UIFontDescriptorSymbolicTraits...) -> UIFont {
        let descriptor = self.fontDescriptor
            .withSymbolicTraits(UIFontDescriptorSymbolicTraits(traits))
        return UIFont(descriptor: descriptor!, size: 0)
    }
    
    func boldItalic() -> UIFont {
        return withTraits(traits: .traitBold, .traitItalic)
    }
    
    func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }
    
}
