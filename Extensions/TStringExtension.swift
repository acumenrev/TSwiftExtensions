//
//  TStringExtension.swift
//  dotabuff
//
//  Created by Tri Vo on 6/24/16.
//  Copyright © 2016 acumen. All rights reserved.
//

import Foundation

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}


extension String {
    /**
     Get name of a class
     
     - parameter aClass: Class
     
     - returns: Class name
     */
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    /**
     Substring from specific index
     
     - parameter from: Index
     
     - returns: Substring value
     */
    func substring(_ from: Int) -> String {
        return self.substring(from: self.characters.index(self.startIndex, offsetBy: from))
    }
    
    /// Length of String
    var length: Int {
        return self.characters.count
    }
    
    /**
     Encoding URL with special characters
     
     - returns: Encoded URL
     */
    func urlEncode() -> String {
        let chars = (CharacterSet.urlQueryAllowed as NSCharacterSet).mutableCopy() as! NSMutableCharacterSet
        //        chars.removeCharactersInString("&")
        
        return self.addingPercentEncoding(withAllowedCharacters: chars as CharacterSet)!
    }
    
    /**
     Compare Insensitive
     
     - parameter value: String need to be compared
     
     - returns: Bool value
     */
    func compareInsensitive(_ value : String) -> Bool {
        if self.lowercased().compare(value) == .orderedSame {
            return true
        }
        return false
    }
    
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func dateForFormat(_ timeFormat : String) -> Date {
        if KPUtils.checkStringNullOrEmpty(self) == false {
            // 0000-00-00 00:00:00
            if self.compareInsensitive("0000-00-00 00:00:00") == true {
                return Date()
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat =  timeFormat
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            let date =  dateFormatter.date(from: self)
            return date!
        }
        return Date()
    }
    
    func dateForSQLFormat() -> Date {
        return self.dateForFormat("yyyy-MM-dd HH:mm:ss")
    }
    
    var lastPathComponent: String {
        
        get {
            return (self as NSString).lastPathComponent
        }
    }
    var pathExtension: String {
        
        get {
            
            return (self as NSString).pathExtension
        }
    }
    var stringByDeletingLastPathComponent: String {
        get {
            
            return (self as NSString).deletingLastPathComponent
        }
    }
    var stringByDeletingPathExtension: String {
        
        get {
            
            return (self as NSString).deletingPathExtension
        }
    }
    var pathComponents: [String] {
        
        get {
            
            return (self as NSString).pathComponents
        }
    }
    
    func stringByAppendingPathComponent(_ path: String) -> String {
        
        let nsSt = self as NSString
        
        return nsSt.appendingPathComponent(path)
    }
    
    func stringByAppendingPathExtension(_ ext: String) -> String? {
        
        let nsSt = self as NSString
        
        return nsSt.appendingPathExtension(ext)
    }
    
    /**
     String for caching on disk
     
     - returns: Converted string
     */
    func stringForCachingOnDisk() -> String {
        let newString = self.replacingOccurrences(of: "/", with: ".").replacingOccurrences(of: ":", with: ".")
        
        return newString
    }
    
    /**
     Compare semantic version
     
     - parameter version: Version will be compared
     
     - returns: ComparisonResult
     */
    func compareAppVersion(_ version : String) -> ComparisonResult {
        var  result : ComparisonResult = .orderedSame
        if self.compareInsensitive(version) == false {
            let arrThisVersion = self.components(separatedBy: ".")
            let arrCompareVersion = version.components(separatedBy: ".")
            
            for index in 0...max(arrThisVersion.count, arrCompareVersion.count) {
                let thisSegment = (index < arrThisVersion.count) ? Int(arrThisVersion[index]) : 0
                let compareSegment = (index < arrCompareVersion.count) ? Int(arrCompareVersion[index]) : 0
                if thisSegment < compareSegment {
                    result = .orderedAscending
                    break
                }
                if thisSegment > compareSegment {
                    result = .orderedDescending
                    break
                }
            }
        }
        return result
    }
    
    
    /// Encrypting key with AES 256
    ///
    /// - returns: Encrypted value
    var encrypted : String? {
        get {
            return AESCrypt.encrypt(self, password: String.uniqueEncryptKey)
        }
    }
    
    
    /// Decrypting string with AES 256
    ///
    /// - returns: Decrypted value
    var decrypted : String? {
        get {
            return AESCrypt.decrypt(self, password: String.uniqueEncryptKey)
        }
    }
    
    /**
     *  Get identifier for vender
     *
     *  @return UDID
     */
    private static var identifier : String? {
        get {
            var udid : String = ""
            #if TARGET_IPHONE_SIMULATOR
                udid = UserDefaults.standard.string(forKey: CANGlobalConstants.KeyUserDefault.udid)
                if CANUtils.checkStringNullOrEmpty(udid) == true {
                    udid = (UIDevice.current.identifierForVendor?.uuidString)!
                    UserDefaults.standard.set(udid, forKey: AppConstants.UserDefaults.udid)
                    UserDefaults.standard.synchronize()
                }
            #else
                udid = (UIDevice.current.identifierForVendor?.uuidString)!
            #endif
            
            return udid
        }
    }
    
    /**
     *  Get Unique encrypt key
     *
     *  @return Encrypt key
     */
    private static var uniqueEncryptKey : String? {
        get {
            let keyToEncrypte = String.identifier!  + "_" + AppConstants.Other.AESKEY
            KPUtils.mLog.debug(keyToEncrypte)
            return keyToEncrypte
        }
    }
    
    
    /// Convert current string to data using UTF-8 encoding
    var toData : Data? {
        get {
            return self.data(using: .utf8, allowLossyConversion: false)
        }
    }
    
    
    /// Localized string
    var toLocalize : String? {
        get {
            return self.localized()
        }
    }
    
    /// Convert base64 string to image data
    var toImageFromBase64 : UIImage? {
        get {
            
            let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters)
            guard data != nil else {
                return nil
            }
            return UIImage(data: data!)
        }
    }
    
    
    /// Youtube link validation
    var isValidYoutubeLink : Bool {
        get {
            let patternRegular = "\\bhttps:\\/\\/www.youtube.com\\/watch\\?v=([\\w-_]+)?"
            let predicate = NSPredicate(format: "SELF MATCHES %@", patternRegular)
            return predicate.evaluate(with: self)
        }
    }
    
    
    /// Get first frame of youtube
    var firstFrameOfYouTube : String {
        get {
            return String(format: "http://img.youtube.com/vi/%@/0.jpg", self)
            
        }
    }
    
    
    /// Is validated email
    var isValidatedEmail : Bool{
        get{
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: self)
        }
    }
    
    var md5: String! {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.deallocate(capacity: digestLen)
        
        return String(format: hash as String)
    }
}


// MARK: - Text Calculation
extension String {
    func heightWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
    
    func heightWithConstrainedStyleWidth(_ width : CGFloat, font : UIFont) -> CGFloat {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 8
        style.lineBreakMode = .byWordWrapping
        style.alignment = .left
        let attributes = [NSFontAttributeName: font,
                          NSParagraphStyleAttributeName : style]
        let textStorage = NSTextStorage(string: self.unicodeToString)
        let textContainer = NSTextContainer(size: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
        let layoutManager = NSLayoutManager()
        
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        textStorage.addAttributes(attributes, range: NSMakeRange(0, textStorage.length))
        textContainer.lineFragmentPadding = 0
        textContainer.lineBreakMode = .byWordWrapping
        
        layoutManager.glyphRange(for: textContainer)
        return layoutManager.usedRect(for: textContainer).size.height
    }
    
    func heightWithConstrainedWidth(_ width: CGFloat) -> CGFloat {
        return heightWithConstrainedWidth(width,font: UIFont.systemFont(ofSize: 17))
    }
    
    func widthWithConstrainedHeight(_ height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    func attributeTextWithFont(_ font: UIFont) -> NSMutableAttributedString{
        
        let convertString = self.unicodeToString
        let attrString = NSMutableAttributedString(string: convertString)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 8
        style.lineBreakMode = .byWordWrapping
        style.alignment = .left
        attrString.addAttributes([NSParagraphStyleAttributeName: style, NSFontAttributeName: font], range: NSMakeRange(0, attrString.length))
        
        return attrString
    }
    
    func attributeTextWithFont(_ font: UIFont, numberOfLine : Int) -> NSMutableAttributedString{
        
        let convertString = self.unicodeToString
        
        let attrString = NSMutableAttributedString(string: convertString)
        let style = NSMutableParagraphStyle()
        if numberOfLine > 1 {
            style.lineSpacing = 8
        }
        
        attrString.addAttributes([NSParagraphStyleAttributeName: style], range: NSMakeRange(0, attrString.length))
        attrString.addAttributes([NSFontAttributeName: font], range: NSMakeRange(0, attrString.length))
        
        return attrString
    }
    
    
    func attributeTextWithFont(_ font: UIFont, style :
        NSMutableParagraphStyle) -> NSMutableAttributedString{
        
        let convertString = self.unicodeToString
        let attrString = NSMutableAttributedString(string: convertString)
        
        attrString.addAttributes([NSParagraphStyleAttributeName: style], range: NSMakeRange(0, attrString.length))
        attrString.addAttributes([NSFontAttributeName: font], range: NSMakeRange(0, attrString.length))
        return attrString
    }
    
    var stringToUnicode: String{
        get{
            
            if let data = self.data(using: String.Encoding.nonLossyASCII){
                if let convertedString = String(data: data, encoding: String.Encoding.utf8){
                    return convertedString
                }
                
            }
            
            return self
        }
    }
    
    var unicodeToString: String{
        get{
            if let data =  self.data(using: String.Encoding.utf8, allowLossyConversion: true){
                if let convertedString = String(data: data, encoding: String.Encoding.nonLossyASCII){
                    return convertedString
                }
            }
            
            return self
        }
    }
}
