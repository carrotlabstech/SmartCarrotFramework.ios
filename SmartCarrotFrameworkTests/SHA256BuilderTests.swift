//
//  SHA256Builder.swift
//  OutlabFrameworkTests
//
//  Copyright © 2019 Outlab gmbh. All rights reserved.
//

import Foundation

import XCTest
@testable import SmartCarrotFramework

class SHA256BuilderTests: XCTestCase {
    func testSHA256() {
        let sha256 = SDH256Builder()
        
        let inputString:String = "com.apple.dt.xctest.tool" + " " + "test.application.ios.v1" + " " + "Hr64DhJaDSTh78Fg90"
        let sha256Hex = sha256.getSHA256StringhHex(string: inputString)
        
        XCTAssertEqual(sha256Hex, "f3bc07f545bc1f92d695d807af591dcf377522d4341cfb54440c262601186309")
    }
}
