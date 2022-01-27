//
//  CarrotContextGlobalTest.swift
//  SmartCarrotFrameworkTests
//
//  Copyright © 2020 CarrotLabs gmbh. All rights reserved.
//

import XCTest
import SmartCarrotFramework

class CarrotContextGlobalTest: XCTestCase {
    func testGlobalVersion() {
        XCTAssertTrue(!CarrotContextGlobal.versionString.isEmpty)
    }
}
