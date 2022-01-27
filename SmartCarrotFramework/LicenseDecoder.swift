//
//  LicenseDecoder.swift
//  SmartCarrotFramework
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import Foundation

internal class LicenseDecoder {
    internal static let MODULE_FULL = "f".u.l.l // "full"
    internal static let MODULE_CATEGORISE = "c".a.t.e.g.o.r.i.s.e // "categorise"
    internal static let MODULE_TRANSACTIONS = "t".x // "tx"
    internal static let MODULE_BUDGETS = "b".u.d.g.e.t.s // "budgets"
    internal static let MODULE_ZEN = "z".e.n // "zen"
    
    internal static let PLATFORM = "i".o.s // "ios"
    internal static let EXPIRATION_DATE_PART_NO = 2
    internal static let MODULES_PART_NO = 3
    internal static let TFL_PART_NO = 5
       
    internal var license:String = ""
//    internal var parts:[Substring] = [Substring]()
    
    internal init(license: String) throws {
//        guard let decoded = license.fromBase64() else {
//            throw CarrotContextError.invalidLicense
//        }
        
//        parts = self.license.split(separator: " ")
    }
    
    internal func checkBundleId(bundleId: String) -> Bool {
        true
    }
    
    internal func checkPlatform() -> Bool {
        return license.contains(LicenseDecoder.PLATFORM)
    }
    
    internal func checkExpirationDate() -> Bool {
        true
    }
    
    internal func checkModules(modules: [String]) -> Bool {
        return true
    }
    
    internal func extractTensorFlowLiteParameters() -> [Int] {
        // To be replaced by proper settings
        return [999,999,999,999,999,999];
    }
}
