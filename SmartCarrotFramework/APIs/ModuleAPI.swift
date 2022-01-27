//
//  ModuleAPI.swift
//  SmartCarrotFramework
//
//  Copyright © 2020 CarrotLabs gmbh. All rights reserved.
//

import Foundation

/// :nodoc:
public class ModuleAPI {
    internal var _credentials: CarrotCredentials?
    internal var _modules = [String]()
    
    internal init(modules: [String], credentials: CarrotCredentials?) {
        _modules.append(LicenseDecoder.MODULE_FULL)
        _modules.append(contentsOf: modules)
        
        _credentials = credentials
    }
    
    internal func validateSettings() throws {
        try _credentials!.validateSignature()
        
        let licenseDecoder = try LicenseDecoder(license: _credentials!.licenseKey)
        if !licenseDecoder.checkModules(modules: _modules) {
            throw CarrotContextError.invalidLicense
        }
    }
}
