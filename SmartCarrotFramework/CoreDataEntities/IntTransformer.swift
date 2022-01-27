//
//  IntTransformer.swift
//  SmartCarrotFramework
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import Foundation

internal class IntTransformer : StringTransformer {
    internal override func transformedValue(_ value: Any?) -> Any? {
        guard let d = value as? Int else {
            return nil
        }
        
        let str = String(d)
        
        return super.transformedValue(str)
    }
    
    internal override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let str = super.reverseTransformedValue(value) as? String else {
            return nil
        }
        
        guard let dInt = Int(str) else {
            return nil
        }
        
        return dInt
    }
}
