//
//  TDictionaryExtension.swift
//  
//
//  Created by Tri Vo on 12/20/16.
//
//

import Foundation

extension Dictionary {
    
    func toJSONString() -> String? {
        let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        let jsonText = String(data: data!, encoding: String.Encoding.utf8)
        return jsonText
    }
}
