//
//  aesEncryptTests.swift
//  SmartCarrotFrameworkTests
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import XCTest
@testable import SmartCarrotFramework

class aesEncryptTests : XCTestCase {
    func testEncryptDecrypt() {
        let message = "this is a message to be encrypted and decrypted $%^ 😍"
        let keyString = "pa$$word"
        let iv = "GKVHJVK78r6567kvkj"
        
        let encoded = message.aesEncrypt(key: keyString, iv: iv)
        let unencode = encoded?.aesDecrypt(key: keyString, iv: iv)
        
        XCTAssertNotNil(encoded)
        XCTAssertEqual(message, unencode)
        XCTAssertNotEqual(message, encoded)
    }
    
    func testWrongPassForDecrypt() {
        let message = "this is a message to be encrypted and decrypted $%^ 😍"
        var keyString = "pa$$word"
        var iv = "GKVHJVK78r6567kvkj"
        
        let encoded = message.aesEncrypt(key: keyString, iv: iv)

        keyString = "pa$$word1"
        var unencode = encoded?.aesDecrypt(key: keyString, iv: iv)
        
        XCTAssertNil(unencode)
        XCTAssertNotEqual(encoded, unencode)

        keyString = "pa$$word"
        iv = "1f;lgjksdlkjfakl;dsjfa;lkdsjk234567890123456"
        unencode = encoded?.aesDecrypt(key: keyString, iv: iv)
        
        // ideally it should be nil, but can't detect it.
        XCTAssertNotEqual(encoded, unencode)
    }
}
