//
//  InputTensorBuilderTests.swift
//  OutlabFramework
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import XCTest
@testable import SmartCarrotFramework

#if DEBUG
class InputTensorBuilderTests: XCTestCase {

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

    func testGetCharacterIndex() {
        let builder = InputTensorBuilder()
        
        XCTAssertEqual(builder.getCharacterIndex(char: " "), 0)
        XCTAssertEqual(builder.getCharacterIndex(char: "a"), 1)
        XCTAssertEqual(builder.getCharacterIndex(char: "z"), 26)
    }
    
    func testGetTripletIndexTest() {
        let builder = InputTensorBuilder()
        
        XCTAssertEqual(builder.getTripletIndex(triplet: "   "), 0)
        XCTAssertEqual(builder.getTripletIndex(triplet: "a  "), 1)
        XCTAssertEqual(builder.getTripletIndex(triplet: "b  "), 2)
        XCTAssertEqual(builder.getTripletIndex(triplet: " a "), 27)
        XCTAssertEqual(builder.getTripletIndex(triplet: "dc "), 85)
        XCTAssertEqual(builder.getTripletIndex(triplet: "xfq"), 12579)
        XCTAssertEqual(builder.getTripletIndex(triplet: "r t"), 14598)
        XCTAssertEqual(builder.getTripletIndex(triplet: "  t"), 14580)
        XCTAssertEqual(builder.getTripletIndex(triplet: "zzz"), 19682)
        
        XCTAssertEqual(builder.getTripletIndex(triplet: "hel"), 8891)
    }

    func testGetTriplets() {
        let builder = InputTensorBuilder()
        
        XCTAssertEqual(builder.getTriplets(description: "hello"), ["hel", "ell", "llo"])
        XCTAssertEqual(builder.getTriplets(description: "hel"), ["hel"])
        XCTAssertEqual(builder.getTriplets(description: "he"), ["he "])
        XCTAssertEqual(builder.getTriplets(description: ""), ["   "])
        XCTAssertEqual(builder.getTriplets(description: "abracaca"), ["abr", "bra", "rac", "aca", "cac"])
        XCTAssertEqual(builder.getTriplets(description: "hel yeah dear"), ["hel", "el ", "l y", " ye", "yea", "eah", "ah ", "h d", " de", "dea", "ear"])
    }
    
    func testGetBasisVector() {
        let builder = InputTensorBuilder()
        
        let basisVector = builder.build(description: "hel yeah dear")
        let expectedNumbers = [8891, 329, 18237, 4320, 889, 5864, 217, 2924, 3753, 868, 13154]
        
        for index in 0...basisVector.count - 1 {
            XCTAssertEqual(basisVector[index], expectedNumbers.contains(index) ? 1 : 0)
        }
    }
}
#endif
