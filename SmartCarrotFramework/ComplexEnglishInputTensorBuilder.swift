//
//  SimpleEnglishInputTensorBuilder.swift
//  SmartCarrotFramework
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import Foundation

internal class ComplexEnglishInputTensorBuilder {
    private let ASCII_ACHAR_NUMBER:Int = 97
    private let X = [22,26,14,11,12,27,7,10,15,23,3,9,17,18,20,24,16,1,25,21,19,13,4,8,2,5,6]
    private let Y = [20,26,18,13,16,25,8,14,12,27,3,9,21,15,10,19,17,1,11,24,22,23,4,5,2,7,6]
    private let Z = [25,27,18,21,11,23,12,10,14,15,4,6,24,13,8,16,26,1,22,20,19,17,9,7,2,3,5]

    func build(description: String) -> [Float32] {
        let triplets = getTriplets(description: description)
        
        var result:[Float32] = [Float32](repeating: 0, count: 27 * 27 * 27 - 2)
        for triplet in triplets {
            let index = getTripletIndex(triplet: triplet)
            if index >= 0 {
                result[index] = 1
            }
        }
        
        // add decoy indexes
        for decoyIndex in getDecoyTripletIndexes(description: description) {
            result[decoyIndex] = 1
        }
        
        return result
    }
    
    func getTriplets(description: String) -> [String] {
        return getTripletsWithDuplicates(description: description).removeDuplicates()
    }
    
    func getTripletsWithDuplicates(description: String) -> [String] {
        var result:[String] = [String]()
        
        if description.count < 3 {
            result = [ description.padding(toLength: 3, withPad: " ", startingAt: 0) ]
        } else {
            for index in 0...description.count - 3 {
                let startIndex = description.index(description.startIndex, offsetBy: index)
                let endIndex = description.index(startIndex, offsetBy: 3)
                result.append(String(description[startIndex ..< endIndex]))
            }
        }
        
        return result
    }
    
    func getDecoyTripletIndexes(description: String) -> [Int] {
        var result = [Int]()
        let magicNumber = getMagicNumber(triplets: getTripletsWithDuplicates(description: description))
//            print(magicNumber)
        
        for xi in 0...9 {
            for yi in 0...9 {
                for zi in 0...9 {
                    if (X[xi] + Y[yi] + Z[zi] + magicNumber) % 10 == 1 {
//                        print("\(xi):\(X[xi]) + \(yi):\(Y[yi]) + \(zi):\(Z[zi]) : \(applyFormula(x: xi + 1, y: yi + 1, z: zi + 1))")
                        result.append(applyFormula(x: xi + 1, y: yi + 1, z: zi + 1))
                    }
                }
            }
        }
        
        return result
    }

    // Accepts duplicates as well!
    internal func getMagicNumber(triplets: [String]) -> Int {
        var result = 0

        for triplet in triplets {
            result = result + getCharacterIndex(char: triplet[0], index: 0) +
                getCharacterIndex(char: triplet[1], index: 1) +
                getCharacterIndex(char: triplet[2], index: 2)
        }

        return result
    }

//    // Accepts duplicates as well!
//    internal func getMagicNumber(triplets: [String]) -> [Int] {
//        var result = [Int]()
//
//        for triplet in triplets {
//            result.append((getCharacterIndex(char: triplet[0], index: 0) +
//                getCharacterIndex(char: triplet[1], index: 1) +
//                getCharacterIndex(char: triplet[2], index: 2)) % 10)
//        }
//
//        return result
//    }

    
   //X=c(  , a, b, c, d,...)
   //X=c(22,26,14,11,12,27,7,10,15,23,3,9,17,18,20,24,16,1,25,21,19,13,4,8,2,5,6),
   //Y=c(20,26,18,13,16,25,8,14,12,27,3,9,21,15,10,19,17,1,11,24,22,23,4,5,2,7,6),
   //Z=c(25,27,18,21,11,23,12,10,14,15,4,6,24,13,8,16,26,1,22,20,19,17,9,7,2,3,5)
   internal func getTripletIndex(triplet: String) -> Int {
        let x = getCharacterIndex(char: triplet[0], index: 0)
        let y = getCharacterIndex(char: triplet[1], index: 1)
        let z = getCharacterIndex(char: triplet[2], index: 2)
        return applyFormula(x: x, y: y, z: z)
    }
    
    internal func applyFormula(x: Int, y: Int, z: Int) -> Int {
        return x + (( x + y - 1) % 27)*27 + ((x + y + z - 1) % 27)*27*27 - 2 - 1 // last -1 because of the difference in R and Swift, array enumeration
    }
    
    internal func getCharacterIndex(char: Character, index: Int) -> Int {
        let pickedArray : [Int]
        
        switch index {
        case 0:
            pickedArray = X
        case 1:
            pickedArray = Y
        case 2:
            pickedArray = Z
        // should not happen, if it happens then you made something wrong
        default:
            pickedArray = X
        }
        
        let charIndex = char == " " ? 0 : Int(char.asciiValue!) - ASCII_ACHAR_NUMBER + 1
        return pickedArray[charIndex]
    }
}
