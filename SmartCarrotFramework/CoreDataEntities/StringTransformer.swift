//
//  StringTransformer.swift
//  SmartCarrotFramework
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import Foundation
import CommonCrypto

internal class StringTransformer: ValueTransformer {
    private let _encoder  = StringEncoder()
    
    internal override class func allowsReverseTransformation() -> Bool {
        return true
    }
    
    internal override func transformedValue(_ value: Any?) -> Any? {
        guard let str = value as? String else {
            return nil
        }
        
        return encode(str)
    }
    
    internal override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else {
            return nil
        }
        
        return decode(data)
    }
    
    internal func encode(_ value: String) -> Data {
        return _encoder.encodeString(value)
    }
    
    internal func decode(_ value: Data) -> String? {
        return _encoder.decodeString(value)
    }
}

internal class StringEncoder {
    internal func encodeString(_ value: String) -> Data {
        return value.aesEncrypt(key: SharedContext.shared.key,
                                iv: SharedContext.shared.iv)!.data(using: .utf8)!
    }
    
    internal func decodeString(_ value: Data) -> String? {
// this is the implementation
        let str = String(data: value, encoding: .utf8)
        let decryptedStr = str!.aesDecrypt(key: SharedContext.shared.key, iv: SharedContext.shared.iv)
        return decryptedStr
        
//        return String(data: value, encoding: .utf8)
    }
    
}

// Taken from here https://stackoverflow.com/questions/27072021/aes-encrypt-and-decrypt
internal extension String {
    func aesEncrypt(key:String, iv:String, options:Int = kCCOptionPKCS7Padding) -> String? {
        if let keyData = key.data(using: String.Encoding.utf8),
            let data = self.data(using: String.Encoding.utf8),
            let cryptData    = NSMutableData(length: Int((data.count)) + kCCBlockSizeAES128) {

            let keyLength              = size_t(kCCKeySizeAES128)
            let operation: CCOperation = UInt32(kCCEncrypt)
            let algoritm:  CCAlgorithm = UInt32(kCCAlgorithmAES128)
            let options:   CCOptions   = UInt32(options)

            var numBytesEncrypted :size_t = 0

            let cryptStatus = CCCrypt(operation,
                                      algoritm,
                                      options,
                                      (keyData as NSData).bytes, keyLength,
                                      iv,
                                      (data as NSData).bytes, data.count,
                                      cryptData.mutableBytes, cryptData.length,
                                      &numBytesEncrypted)

            if UInt32(cryptStatus) == UInt32(kCCSuccess) {
                cryptData.length = Int(numBytesEncrypted)
                let base64cryptString = cryptData.base64EncodedString(options: .lineLength64Characters)
                return base64cryptString
            }
            else {
                return nil
            }
        }
        return nil
    }

    func aesDecrypt(key:String, iv:String, options:Int = kCCOptionPKCS7Padding) -> String? {
        if let keyData = key.data(using: String.Encoding.utf8),
            let data = NSData(base64Encoded: self, options: .ignoreUnknownCharacters),
            let cryptData    = NSMutableData(length: Int((data.length)) + kCCBlockSizeAES128) {

            let keyLength              = size_t(kCCKeySizeAES128)
            let operation: CCOperation = UInt32(kCCDecrypt)
            let algoritm:  CCAlgorithm = UInt32(kCCAlgorithmAES128)
            let options:   CCOptions   = UInt32(options)

            var numBytesEncrypted :size_t = 0

            let cryptStatus = CCCrypt(operation,
                                      algoritm,
                                      options,
                                      (keyData as NSData).bytes, keyLength,
                                      iv,
                                      data.bytes, data.length,
                                      cryptData.mutableBytes, cryptData.length,
                                      &numBytesEncrypted)

            if UInt32(cryptStatus) == UInt32(kCCSuccess) {
                cryptData.length = Int(numBytesEncrypted)
                let unencryptedMessage = String(data: cryptData as Data, encoding:String.Encoding.utf8)
                return unencryptedMessage
            }
            else {
                return nil
            }
        }
        return nil
    }
}

