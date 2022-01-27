
//
//  SHA256Builder.swift
//  SmartCarrotFramework
//
//  Copyright © 2019 Outlab gmbh. All rights reserved.
//

import Foundation
import var CommonCrypto.CC_SHA256_DIGEST_LENGTH
import func CommonCrypto.CC_SHA256
import typealias CommonCrypto.CC_LONG

internal class SDH256Builder {
    /// Generates SHA256 Hash
    private func getHash(string: String) -> Data {
        let length = Int(CC_SHA256_DIGEST_LENGTH)
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: length)
        
        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_SHA256(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData
    }

    internal func getSHA256StringhHex(string: String) -> String {
        let sha256Data = getHash(string: string)
        return sha256Data.map { String(format: "%02hhx", $0) }.joined()
    }
}
