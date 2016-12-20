//
//  TAttributedStringExtension.swift
//  
//
//  Created by Tri Vo on 12/20/16.
//
//

import Foundation

extension NSAttributedString {
    func heightWithConstrainedWidth(_ width: CGFloat) -> CGFloat {
        
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [NSStringDrawingOptions.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        
        let framesetter = CTFramesetterCreateWithAttributedString(self as CFAttributedString);
        
        let targetSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        var fitRange = CFRange()
        
        let size = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), nil, targetSize, &fitRange)
        return ceil(size.height)
        
    }
    
    func heightWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat{
        let framesetter = CTFramesetterCreateWithAttributedString(self as CFAttributedString);
        
        let targetSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        var fitRange = CFRange()
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 8
        style.lineBreakMode = .byWordWrapping
        style.maximumLineHeight = 8
        style.maximumLineHeight = 8
        style.lineHeightMultiple = 1.0
        
        let dictionary = NSDictionary(dictionary: [NSParagraphStyleAttributeName: style, NSFontAttributeName: font])
        let size = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), dictionary as CFDictionary, targetSize, &fitRange)
        
        return ceil(size.height)
    }
    
    func widthWithConstrainedHeight(_ height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.width)
    }
}
