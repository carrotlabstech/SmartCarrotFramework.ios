//
//  ComplexEnglishInputTensorBuilderTest.swift
//  SmartCarrotFrameworkTests
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import XCTest
@testable import SmartCarrotFramework

class ComplexEnglishInputTensorBuilderTest : XCTestCase {
    let builder = ComplexEnglishInputTensorBuilder()
    
    func testGetTripletIndex() {
        XCTAssertEqual(builder.getTripletIndex(triplet: " aa"), 15139)
        XCTAssertEqual(builder.getTripletIndex(triplet: " a "), 13681)
        XCTAssertEqual(builder.getTripletIndex(triplet: "sos"), 3987)
        
        XCTAssertLessThan(builder.getTripletIndex(triplet: "xaa"), 0)
        XCTAssertLessThan(builder.getTripletIndex(triplet: "qia"), 0)
        XCTAssertEqual(builder.getTripletIndex(triplet: "qoa"), 14362)
    }
    
    func testCharIndex() {
        let triplet = " aa"
        
        let x = builder.getCharacterIndex(char: triplet[0], index: 0)
        let y = builder.getCharacterIndex(char: triplet[1], index: 1)
        let z = builder.getCharacterIndex(char: triplet[2], index: 2)
        
        XCTAssertEqual(x, 22)
        XCTAssertEqual(y, 26)
        XCTAssertEqual(z, 27)
    }
    
    func testMagicNumber() {
        XCTAssertEqual(builder.getMagicNumber(triplets: builder.getTripletsWithDuplicates(description: "aaa")), 79)
        XCTAssertEqual(builder.getMagicNumber(triplets: ["aaa"]), 79)
        XCTAssertEqual(builder.getMagicNumber(triplets: ["qia"]), 55)
        
        XCTAssertEqual(builder.getMagicNumber(triplets: builder.getTripletsWithDuplicates(description: "qia xaa and friends")), 961)
        
        XCTAssertEqual(builder.getMagicNumber(triplets: builder.getTripletsWithDuplicates(description: "cash withdrawal card rb kaiserstuhl on id amount eur charges min eur eur total debit eur rate eurchf")), 5783)
    }
    
    func testBuild() {
        var inputTensor = builder.build(description: "qia xaa and friends")
        
        var trueValues = [Int]()
        for i in 0...inputTensor.count - 1 {
            if inputTensor[i] == 1 {
                trueValues.append(i)
            }
        }
        XCTAssertEqual(trueValues.count, 118)
        
        inputTensor = builder.build(description: "cash withdrawal card rb kaiserstuhl on id amount eur charges min eur eur total debit eur rate eurchf")
        trueValues = [Int]()
        for i in 0...inputTensor.count - 1 {
            if inputTensor[i] == 1 {
                trueValues.append(i)
            }
        }
        XCTAssertEqual(trueValues.count, 184)
        
        inputTensor = builder.build(description: "coop tankstelle")
        trueValues = [Int]()
        for i in 0...inputTensor.count - 1 {
            if inputTensor[i] == 1 {
                print(i)
                trueValues.append(i)
            }
        }
        XCTAssertEqual(trueValues.count, 113)

    }
    
    func testBuildUS() {
        let inputTensor = builder.build(description: "donalds")
        
        var trueValues = [Int]()
        for i in 0...inputTensor.count - 1 {
            if inputTensor[i] == 1 {
                trueValues.append(i)
            }
        }
        XCTAssertEqual(trueValues.count, 108)
    }
    
    func testTripletsWithDuplicates() {
        let tripletsWithDuplicates = builder.getTripletsWithDuplicates(description: "qia xaa and friends")
        
        for triplet in tripletsWithDuplicates {
            print("\(builder.getCharacterIndex(char: triplet[0], index: 0)) \(builder.getCharacterIndex(char: triplet[1], index: 1)) \(builder.getCharacterIndex(char: triplet[2], index: 2))")
        }
        
        XCTAssertEqual(tripletsWithDuplicates.count, 17)
    }
    
    func testIndexes() {
        let realTriplets = builder.getTriplets(description: "coop tankstelle")
        var realIndexes = realTriplets.map({ builder.getTripletIndex(triplet: $0) })
        
        let expectedIndexes = [229, 4658, 8391, 8442,9925,10445,10632,12115,12957,13184,15353,17637, 18700]
        
        realIndexes.sort()
        XCTAssertEqual(expectedIndexes, realIndexes)
    }
    
    func testIndexesUS() {
        var realTriplets = builder.getTriplets(description: "gas")
        var realIndexes = realTriplets.map({ builder.getTripletIndex(triplet: $0) })
        
        var expectedIndexes = [952]
        
        realIndexes.sort()
        XCTAssertEqual(expectedIndexes, realIndexes)
        
        realTriplets = builder.getTriplets(description: "plane")
        realIndexes = realTriplets.map({ builder.getTripletIndex(triplet: $0) })
        
        expectedIndexes = [3155, 6817, 17186]
        
        realIndexes.sort()
        XCTAssertEqual(expectedIndexes, realIndexes)
        
        realTriplets = builder.getTriplets(description: "amazon")
        realIndexes = realTriplets.map({ builder.getTripletIndex(triplet: $0) })
        
        expectedIndexes = [4296, 9851, 14711, 15756]
        
        realIndexes.sort()
        XCTAssertEqual(expectedIndexes, realIndexes)
    }
    
    
}
