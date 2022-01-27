//
//  DateTransformer.swift
//  SmartCarrotFramework
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import Foundation

internal class DateTransformer : StringTransformer {
    internal override func transformedValue(_ value: Any?) -> Any? {
        guard let d = value as? Date else {
            return nil
        }
        
        let str = String(d.timeIntervalSince1970)
        
        return super.transformedValue(str)
    }
    
    internal override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let str = super.reverseTransformedValue(value) as? String else {
            return nil
        }
        
        guard let dInt = Double(str) else {
            return nil
        }
        
        return Date(timeIntervalSince1970: Double(dInt))
    }
}
