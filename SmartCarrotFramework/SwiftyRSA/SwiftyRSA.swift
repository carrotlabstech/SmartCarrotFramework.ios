//
//  SwiftyRSA.swift
//  SwiftyRSA
//
//  Created by Loïs Di Qual on 7/2/15.
//  Copyright (c) 2015 Scoop Technologies, Inc. All rights reserved.
//

import Foundation

internal typealias Padding = SecPadding

internal enum SwiftyRSA {
    
    static func base64String(pemEncoded pemString: String) throws -> String {
        let lines = pemString.components(separatedBy: "\n").filter { line in
//            return !line.hasPrefix("-----BEGIN") && !line.hasPrefix("-----END")
            return !line.hasPrefix(String().dash.dash.dash.dash.dash.B.E.G.I.N) && !line.hasPrefix(String().dash.dash.dash.dash.dash.E.N.D)
        }
        
        guard lines.count != 0 else {
            throw SwiftyRSAError.pemDoesNotContainKey
        }
        
        return lines.joined(separator: "")
    }
        
    static func addKey(_ keyData: Data, isPublic: Bool, tag: String) throws ->  SecKey {
        
        let keyData = keyData
        
        guard let tagData = tag.data(using: .utf8) else {
            throw SwiftyRSAError.tagEncodingFailed
        }
        
        let keyClass = isPublic ? kSecAttrKeyClassPublic : kSecAttrKeyClassPrivate
        
        // On iOS 10+, we can use SecKeyCreateWithData without going through the keychain
        if #available(iOS 10.0, *), #available(watchOS 3.0, *), #available(tvOS 10.0, *) {
            
            let sizeInBits = keyData.count * 8
            let keyDict: [CFString: Any] = [
                kSecAttrKeyType: kSecAttrKeyTypeRSA,
                kSecAttrKeyClass: keyClass,
                kSecAttrKeySizeInBits: NSNumber(value: sizeInBits),
                kSecReturnPersistentRef: true
            ]
            
            var error: Unmanaged<CFError>?
            guard let key = SecKeyCreateWithData(keyData as CFData, keyDict as CFDictionary, &error) else {
                throw SwiftyRSAError.keyCreateFailed(error: error?.takeRetainedValue())
            }
            return key
            
        // On iOS 9 and earlier, add a persistent version of the key to the system keychain
        } else {
            
            let persistKey = UnsafeMutablePointer<AnyObject?>(mutating: nil)
            
            let keyAddDict: [CFString: Any] = [
                kSecClass: kSecClassKey,
                kSecAttrApplicationTag: tagData,
                kSecAttrKeyType: kSecAttrKeyTypeRSA,
                kSecValueData: keyData,
                kSecAttrKeyClass: keyClass,
                kSecReturnPersistentRef: true,
                kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock
            ]
            
            let addStatus = SecItemAdd(keyAddDict as CFDictionary, persistKey)
            guard addStatus == errSecSuccess || addStatus == errSecDuplicateItem else {
                throw SwiftyRSAError.keyAddFailed(status: addStatus)
            }
            
            let keyCopyDict: [CFString: Any] = [
                kSecClass: kSecClassKey,
                kSecAttrApplicationTag: tagData,
                kSecAttrKeyType: kSecAttrKeyTypeRSA,
                kSecAttrKeyClass: keyClass,
                kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock,
                kSecReturnRef: true,
            ]
            
            // Now fetch the SecKeyRef version of the key
            var keyRef: AnyObject?
            let copyStatus = SecItemCopyMatching(keyCopyDict as CFDictionary, &keyRef)
            
            guard let unwrappedKeyRef = keyRef else {
                throw SwiftyRSAError.keyCopyFailed(status: copyStatus)
            }
            
            return unwrappedKeyRef as! SecKey // swiftlint:disable:this force_cast
        }
    }
    
    /**
     This method strips the x509 header from a provided ASN.1 DER key.
     If the key doesn't contain a header, the DER data is returned as is.
     
     Supported formats are:
     
     Headerless:
     SEQUENCE
         INTEGER (1024 or 2048 bit) -- modulo
         INTEGER -- public exponent
     
     With x509 header:
     SEQUENCE
         SEQUENCE
         OBJECT IDENTIFIER 1.2.840.113549.1.1.1
         NULL
         BIT STRING
         SEQUENCE
         INTEGER (1024 or 2048 bit) -- modulo
         INTEGER -- public exponent
     
     Example of headerless key:
     https://lapo.it/asn1js/#3082010A0282010100C1A0DFA367FBC2A5FD6ED5A071E02A4B0617E19C6B5AD11BB61192E78D212F10A7620084A3CED660894134D4E475BAD7786FA1D40878683FD1B7A1AD9C0542B7A666457A270159DAC40CE25B2EAE7CCD807D31AE725CA394F90FBB5C5BA500545B99C545A9FE08EFF00A5F23457633E1DB84ED5E908EF748A90F8DFCCAFF319CB0334705EA012AF15AA090D17A9330159C9AFC9275C610BB9B7C61317876DC7386C723885C100F774C19830F475AD1E9A9925F9CA9A69CE0181A214DF2EB75FD13E6A546B8C8ED699E33A8521242B7E42711066AEC22D25DD45D56F94D3170D6F2C25164D2DACED31C73963BA885ADCB706F40866B8266433ED5161DC50E4B3B0203010001
     
     Example of key with X509 header (notice the additional ASN.1 sequence):
     https://lapo.it/asn1js/#30819F300D06092A864886F70D010101050003818D0030818902818100D0674615A252ED3D75D2A3073A0A8A445F3188FD3BEB8BA8584F7299E391BDEC3427F287327414174997D147DD8CA62647427D73C9DA5504E0A3EED5274A1D50A1237D688486FADB8B82061675ABFA5E55B624095DB8790C6DBCAE83D6A8588C9A6635D7CF257ED1EDE18F04217D37908FD0CBB86B2C58D5F762E6207FF7B92D0203010001
     */
    static func stripKeyHeader(keyData: Data) throws -> Data {
        
        let node: Asn1Parser.Node
        do {
            node = try Asn1Parser.parse(data: keyData)
        } catch {
            throw SwiftyRSAError.asn1ParsingFailed
        }
        
        // Ensure the raw data is an ASN1 sequence
        guard case .sequence(let nodes) = node else {
            throw SwiftyRSAError.invalidAsn1RootNode
        }
        
        // Detect whether the sequence only has integers, in which case it's a headerless key
        let onlyHasIntegers = nodes.filter { node -> Bool in
            if case .integer = node {
                return false
            }
            return true
        }.isEmpty
        
        // Headerless key
        if onlyHasIntegers {
            return keyData
        }
        
        // If last element of the sequence is a bit string, return its data
        if let last = nodes.last, case .bitString(let data) = last {
            return data
        }
        
        // If last element of the sequence is an octet string, return its data
        if let last = nodes.last, case .octetString(let data) = last {
            return data
        }
        
        // Unable to extract bit/octet string or raw integer sequence
        throw SwiftyRSAError.invalidAsn1Structure
    }
    
    static func removeKey(tag: String) {
        
        guard let tagData = tag.data(using: .utf8) else {
            return
        }
        
        let keyRemoveDict: [CFString: Any] = [
            kSecClass: kSecClassKey,
            kSecAttrKeyType: kSecAttrKeyTypeRSA,
            kSecAttrApplicationTag: tagData,
        ]
        
        SecItemDelete(keyRemoveDict as CFDictionary)
    }
}
