//
//  CarrotCredentials.swift
//  SmartCarrotFramework
//
//  Copyright © 2020 CarrotLabs gmbh. All rights reserved.
//

import Foundation

/// Converts a (license) string (formatted as json) to two strings, a license and a signature
internal struct CarrotCredentials : Codable {
    internal let licenseKey: String
    internal let signature: String
    
    internal init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw CarrotContextError.invalidLicense
        }
        try self.init(data: data)
    }

    internal init(data: Data) throws {
        do {
            self = try JSONDecoder().decode(CarrotCredentials.self, from: data)
        } catch {
            throw CarrotContextError.invalidLicense
        }
    }
    
    internal func isEmpty() -> Bool {
        return signature.isEmpty || licenseKey.isEmpty
    }
    
    internal func validateSignature() throws {
        if isEmpty() {
            throw CarrotContextError.invalidLicense
        }
        
        if try !DigitalSignature().validate(license: licenseKey, signature: signature) {
            throw CarrotContextError.invalidLicense
        }
    }
}
