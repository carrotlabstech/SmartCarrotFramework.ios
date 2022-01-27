//
//  PublicKey.swift
//  SwiftyRSA
//
//  Created by Lois Di Qual on 5/17/17.
//  Copyright © 2017 Scoop. All rights reserved.
//

import Foundation

internal class PublicKey: Key {
    
    /// Reference to the key within the keychain
    internal let reference: SecKey
    
    /// Data of the public key as provided when creating the key.
    /// Note that if the key was created from a base64string / DER string / PEM file / DER file,
    /// the data holds the actual bytes of the key, not any textual representation like PEM headers
    /// or base64 characters.
    internal let originalData: Data?
    
    internal let tag: String? // Only used on iOS 8/9
    
    /// Data of the public key as returned by the keychain.
    /// This method throws if SwiftyRSA cannot extract data from the key.
    ///
    /// - Returns: Data of the public key as returned by the keychain.
    /// - Throws: SwiftyRSAError
    required internal init(data: Data) throws {
        
        let tag = UUID().uuidString
        self.tag = tag
        
        self.originalData = data
        let dataWithoutHeader = try SwiftyRSA.stripKeyHeader(keyData: data)
        
        reference = try SwiftyRSA.addKey(dataWithoutHeader, isPublic: true, tag: tag)
    }
    
    deinit {
        if let tag = tag {
            SwiftyRSA.removeKey(tag: tag)
        }
    }
}
