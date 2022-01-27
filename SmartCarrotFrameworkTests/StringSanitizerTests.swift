//
//  ModelProtocol.swift
//  OutlabFramework
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import XCTest
@testable import SmartCarrotFramework

class StringSanitizerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testSanitization() {
        XCTAssertEqual(StringSanitizer.cleanseString(arg: ""), "")
        XCTAssertEqual(StringSanitizer.cleanseString(arg: "привет"), "")
        XCTAssertEqual(StringSanitizer.cleanseString(arg: "/hɛlˈviːʃə/"), "hlvi")
        XCTAssertEqual(StringSanitizer.cleanseString(arg: "アニメ"), "")
        XCTAssertEqual(StringSanitizer.cleanseString(arg: "💖worldа"), "world")
        XCTAssertEqual(StringSanitizer.cleanseString(arg: "grüezi"), "grueezi")
        XCTAssertEqual(StringSanitizer.cleanseString(arg: "grüe|zi"), "grueezi")
        XCTAssertEqual(StringSanitizer.cleanseString(arg: "    (The) Quiçk45 & brown föx-juMPed_over  456 a b c99    \t\n the lazy à dogs.?  "), "the quickxqzptxbrown foex jumped over the lazy dogs")
    }
}
