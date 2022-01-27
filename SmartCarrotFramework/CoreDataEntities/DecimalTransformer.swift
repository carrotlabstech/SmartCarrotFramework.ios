//
//  DecimalTransformer.swift
//  SmartCarrotFramework
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import Foundation

internal class DecimalTransformer : StringTransformer {
    internal override func transformedValue(_ value: Any?) -> Any? {
        guard let d = value as? Decimal else {
            return nil
        }
        
        let str = String(describing: d)
        
        return super.transformedValue(str)
    }
    
    internal override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let str = super.reverseTransformedValue(value) as? String else {
            return nil
        }
        
        guard let d = Decimal(string: str) else {
            return nil
        }
        
        return d
    }
}
