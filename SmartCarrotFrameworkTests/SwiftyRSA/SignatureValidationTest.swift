//
//  SignatureValidationTest.swift
//
//  Copyright © 2019 CarrotLabs. All rights reserved.
//

import Foundation
import XCTest
@testable import SmartCarrotFramework

class SignatureValidationTest : XCTestCase {
    private let _publicKey = """
    -----BEGIN PUBLIC KEY-----
    MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAr5fgPRGK2ehoTubgZqVf
    B9jp1PU/hI47rUkhP9etSLm5ecwb706KcLCzfLXG0LX6lvg4xoh/7jcFO4XMht/Z
    YxUujLlJFshpGRU9ex04I4PVPNF0cC3NkOP3JMkc2wSrsfl3/82YmsfqVsOIKEQf
    DBJh1VYCiXVwxKwWPjK+x1KSPlYt7RLLrC5M1OsLt/GWVXAhwtpAIm7GL45nol+Y
    HelhDOnOBwkGvsmJH+fVLb5qMR7PQZrKhEd4+vMnVu7gJN5x9zfXEhyWtFSihmpY
    uMicUn4Oi2EYDLkjNR3cbgPS/9r/IOIJwFZ8qamt6a7vffW9HEciNPdgQVTGoqsn
    AGXSPRCrCom3vS0Z2zyhr2xxGbk0fHs+CDTjNOo3rBqvpdGKpGe9+6Gh92+97E40
    nRfReEKMiSyzLl/48/AqtkBUGhKqf96oL5ZFvjQS/i0xV5QKExrUseGEbZbXGNvR
    m6K/oDPuxcRp76zKqTeFbEGkoDjYF/0CnZhqxaQCDCMmyGCZrWqXU25FL1GihUyV
    rYSV4HNwPlpoys4YgbRI3O3wIiBJf9lIGf5GXYN+0FIYyu39tZH/9lLv6Io9AmWt
    tY4Bj9ufUfK9Z4lRIBfuOQXA8tnCoRfDNZuPwF6Htpy2PSHRnxpY5R7zV2D/Hij7
    XadRv0/JR61HOIJsIy2kRc8CAwEAAQ==
    -----END PUBLIC KEY-----
    """
    
    private let _shaBase64String = "C+0CnXVhCUwOtjR18lVsq+P94Is4iWQ5kHpCoLZEBZvGdSoGRlpEkSFDJq3ihgg/SDe5kz1n7YBps0D/rIeZ2ZxxOxZvrDRmsia7/wdkL6QVXrYAW/e8FRVV+3g3KEjvO5CnTK2l+AXMWnqEcxzFilG6+SI1XRNZF867NclO5v3kw+1QXwVlPfsOb67+uY6cFV+nOuiLXh5t5cmeMiui2BZv2CrTa4+kzxIKWZrM5XcGEq8BSTJ6a4a9f8u1kK2AJ2/6kb6mV1xCFxRXyj+wC4AFs+oMFj66aW6dI+baHp9zthZJny6bfYfhBjN2LNecZkGhewtE2phZcx8ZtMcolR4Ft7x5cRIQVHWqlJj558DSu2eaWVFuzyeF9iS2/Bwc7DjkLmwikZBsOF/tyY3/qkbUvfIbHRmNgVg7wZhKSYR+Lza/yw/3E7vaJOFKPwVbFyr+Uyt4Ba3IaBoHHAdIAMPvS3l91vBg26+b0nTHW5U1Qv4mC4ai3fM2Q2rmq6lgDV7+TZqJoO8iTO2NKf8nUB7Vt2NDxXX1CrLPAWO2tYqMByH+4WcHQd8R3uztic/86K8GrbYRaVHjlB2UradKYlyKEzmhxHQowJfM6H1zImsmBOsKuVJ3kPOJcDCcq5p6xvVScvZ0yoYGG8qzUVlWz0QB0KABEp58aMK9W64VD4k="
    
    func testLoadPublicKey() throws {
        //let publicKey = try! TestUtils.publicKey(name: "carrotlabs.pem")
        let publicKey = try PublicKey(pemEncoded: _publicKey)
        
        let message = "com.carrotlabs.categorydemoapp License:ASDKFA26783SKFJAI:SDJFH93DSKHAKHDF9G:02102019"
        let clear = try ClearMessage(string: message, using: .utf8)

//        let bundle = Bundle(for: TestUtils.self)
//        guard let path = bundle.path(forResource: "sha1", ofType: "sign") else {
//            throw TestError(description: "Couldn't load signature")
//        }
//        guard let pathMessage = bundle.path(forResource: "license", ofType: "key") else {
//            throw TestError(description: "Couldn't load license")
//        }
//        guard let pathPubKey = bundle.path(forResource: "carrotlabs", ofType: "pem") else {
//            throw TestError(description: "Couldn't load pub key")
//        }

// this does work too
//        let pemString = try String(contentsOf: URL(fileURLWithPath: pathPubKey))
//        let publicKey =  try PublicKey(pemEncoded: pemString)
        
 //   this does work too
//        let signatureData = try Data(contentsOf: URL(fileURLWithPath: path))
//        let signature = Signature(data: signatureData)
   
        // base64 must be on the only line, then this works
        let signature = try Signature(base64Encoded: _shaBase64String)
        
        // this does work too
//        let messageData = try Data(contentsOf: URL(fileURLWithPath: pathMessage))
//        let clear = ClearMessage(data: messageData)
        
        let isSuccessful = try clear.verify(with: publicKey, signature: signature, digestType: .sha256)
        
        XCTAssertTrue(isSuccessful)
    }
}
