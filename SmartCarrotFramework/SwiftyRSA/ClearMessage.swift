//
//  ClearMessage.swift
//  SwiftyRSA
//
//  Created by Lois Di Qual on 5/18/17.
//  Copyright © 2017 Scoop. All rights reserved.
//

import Foundation

internal class ClearMessage: Message {
    
    /// Data of the message
    internal let data: Data
    
    /// Creates a clear message with data.
    ///
    /// - Parameter data: Data of the clear message
    internal required init(data: Data) {
        self.data = data
    }
    
    /// Creates a clear message from a string, with the specified encoding.
    ///
    /// - Parameters:
    ///   - string: String value of the clear message
    ///   - encoding: Encoding to use to generate the clear data
    /// - Throws: SwiftyRSAError
    internal convenience init(string: String, using encoding: String.Encoding) throws {
        guard let data = string.data(using: encoding) else {
            throw SwiftyRSAError.stringToDataConversionFailed
        }
        self.init(data: data)
    }
    
    /// Returns the string representation of the clear message using the specified
    /// string encoding.
    ///
    /// - Parameter encoding: Encoding to use during the string conversion
    /// - Returns: String representation of the clear message
    /// - Throws: SwiftyRSAError
    internal func string(encoding: String.Encoding) throws -> String {
        guard let str = String(data: data, encoding: encoding) else {
            throw SwiftyRSAError.dataToStringConversionFailed
        }
        return str
    }
    
    /// Verifies the signature of a clear message.
    ///
    /// - Parameters:
    ///   - key: Public key to verify the signature with
    ///   - signature: Signature to verify
    ///   - digestType: Digest type used for the signature
    /// - Returns: Result of the verification
    /// - Throws: SwiftyRSAError
    internal func verify(with key: PublicKey, signature: Signature, digestType: Signature.DigestType) throws -> Bool {
        
        let digest = self.digest(digestType: digestType)
        var digestBytes = [UInt8](repeating: 0, count: digest.count)
        (digest as NSData).getBytes(&digestBytes, length: digest.count)
        
        var signatureBytes = [UInt8](repeating: 0, count: signature.data.count)
        (signature.data as NSData).getBytes(&signatureBytes, length: signature.data.count)
        
        let status = SecKeyRawVerify(key.reference, digestType.padding, digestBytes, digestBytes.count, signatureBytes, signatureBytes.count)
        
        if status == errSecSuccess {
            return true
        } else if status == -9809 {
            return false
        } else {
            throw SwiftyRSAError.signatureVerifyFailed(status: status)
        }
    }
    
    internal func digest(digestType: Signature.DigestType) -> Data {
        
        let digest: Data
        
        switch digestType {
        case .sha1:
            digest = (data as NSData).swiftyRSASHA1()
        case .sha224:
            digest = (data as NSData).swiftyRSASHA224()
        case .sha256:
            digest = (data as NSData).swiftyRSASHA256()
        case .sha384:
            digest = (data as NSData).swiftyRSASHA384()
        case .sha512:
            digest = (data as NSData).swiftyRSASHA512()
        }
        
        return digest
    }
}
