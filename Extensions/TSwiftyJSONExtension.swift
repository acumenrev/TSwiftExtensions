//
//  TSwiftyJSONExtension.swift
//  
//
//  Created by Tri Vo on 12/20/16.
//
//

import Foundation
import SwiftyJSON

extension JSON {
    
    
    
    /**
     String for key
     
     - parameter key: Key
     
     - returns: String value
     */
    func stringForKey(_ key : String) -> String {
        if self[key] != nil {
            return self[key].stringValue
        }
        
        return ""
    }
    
    /**
     int for key
     
     - parameter key: Key
     
     - returns: Int value
     */
    func intForKey(_ key : String) -> Int {
        if self[key] != nil {
            return self[key].intValue
        }
        return 0
    }
    
    /**
     Int8 For Key
     
     - parameter key: Key
     
     - returns: Int8 Value
     */
    func int8ForKey(_ key : String) -> Int8 {
        if self[key] != nil {
            return self[key].int8Value
        }
        return 0
    }
    
    /**
     Int16 For Key
     
     - parameter key: Key
     
     - returns: Int16 Value
     */
    func int16ForKey(_ key : String) -> Int16 {
        if self[key] != nil {
            return self[key].int16Value
        }
        
        return 0
    }
    
    /**
     Int32 For Key
     
     - parameter key: Key
     
     - returns: Int32 Value
     */
    func int32ForKey(_ key : String) -> Int32 {
        if self[key] != nil {
            return self[key].int32Value
        }
        return 0
    }
    
    /**
     Int64 For Key
     
     - parameter key: Key
     
     - returns: Int64 Value
     */
    func int64ForKey(_ key : String) -> Int64 {
        if self[key] != nil {
            return self[key].int64Value
        }
        
        return 0
    }
    
    /**
     UInt For Key
     
     - parameter key: Key
     
     - returns: UInt Value
     */
    func uintForKey(_ key : String) -> UInt {
        if self[key] != nil {
            return self[key].uIntValue
        }
        
        return 0
    }
    
    /**
     UInt8 For Key
     
     - parameter key: Key
     
     - returns: UInt8 Value
     */
    func uint8ForKey(_ key : String) -> UInt8 {
        
        if self[key] != nil {
            return self[key].uInt8Value
        }
        
        return 0
    }
    
    /**
     UInt16 For Key
     
     - parameter key: Key
     
     - returns: UInt16 Value
     */
    func uint16ForKey(_ key : String) -> UInt16 {
        
        if self[key] != nil {
            return self[key].uInt16Value
        }
        return 0
    }
    
    /**
     UInt32 For Key
     
     - parameter key: Key
     
     - returns: UInt32 Value
     */
    func uint32ForKey(_ key : String) -> UInt32 {
        
        if self[key] != nil {
            return self[key].uInt32Value
        }
        
        return 0
    }
    
    /**
     UInt64 For Key
     
     - parameter key: Key
     
     - returns: UInt64 Value
     */
    func uint64ForKey(_ key : String) -> UInt64 {
        
        if self[key] != nil {
            return self[key].uInt64Value
        }
        
        return 0
    }
    
    /**
     Double for key
     
     - parameter key: Key
     
     - returns: Double value
     */
    func doubleForKey(_ key : String) -> Double {
        
        if self[key] != nil {
            return self[key].doubleValue
        }
        
        return 0.0
    }
    
    /**
     Float for key
     
     - parameter key: Key
     
     - returns: Float value
     */
    func floatForKey(_ key : String) -> Float {
        
        if self[key] != nil {
            return self[key].floatValue
        }
        
        return 0.0
    }
    
    /**
     Bool for key
     
     - parameter key: Key
     
     - returns: Bool value
     */
    func boolForKey(_ key : String) -> Bool {
        
        if self[key] != nil {
            return self[key].boolValue
        }
        
        return false
    }
    
    /**
     Array for key
     
     - parameter key: Key
     
     - returns: Array
     */
    func arrayForKey(_ key : String) -> [AnyObject]? {
        
        if self[key] != nil {
            return self[key].arrayObject as [AnyObject]?
        }
        
        return nil
    }
}
