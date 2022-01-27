//
//  CategorisationAPITest.swift
//  SmartCarrotFrameworkTests
//
//  Copyright © 2020 CarrotLabs gmbh. All rights reserved.
//

import XCTest
@testable import SmartCarrotFramework

class CategorisationAPITest: XCTestCase {
    private var categorisationAPI : CategorisationAPI? = nil
    private var carrotContext = CarrotContext(persistance: .ephemeral)
    
    override func setUp() {
        do {
            carrotContext.setEncryption(key: GlobalsTests.ENCRYPTION_PASSWORD, iv: GlobalsTests.ENCRYPTION_IV)
            try carrotContext.setLicense(license: GlobalsTests.VALID_LICENSE)
            
            categorisationAPI = try carrotContext.getCategorisationAPI()
            try categorisationAPI!.reset()
        } catch {
            print(error)
            XCTAssertTrue(false)
        }
    }

#if COUNTRY_US
    func testCategorisationUS() {
        XCTAssertEqual(61, try? categorisationAPI!.categorise(description: "Google Inc.", amount: -100, isPersonal: .nonPersonal))
    }
#endif
}
