//
//  TIntExtension.swift
//  
//
//  Created by Tri Vo on 12/20/16.
//
//

import Foundation

extension Int {
    var stringValue:String {
        return "\(self)"
    }
    
    var toData:Data! {
        mutating get {
            let data = Data(bytes: &self, count: 3)
            return data
        }
    }
}
