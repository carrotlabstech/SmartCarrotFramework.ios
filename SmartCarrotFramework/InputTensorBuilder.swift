//
//  InputTensorBuilder.swift
//  SmartCarrotFramework
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import Foundation

// Builds the basis vector / tensor as the input for the optimized prime model
//
// IMPORTANT: We assume that all the characters in the input string are ASCII, that should be done with a help of another class

#if DEBUG
// this variable is not set in the settings in order to prvent the compiler from adding this code into the release code.
// otherwise it shows in the decompiler and it is too easy to crack it and understand the triplets.
internal class InputTensorBuilder {
    private let ASCII_ACHAR_NUMBER:Int = 97

    internal func build(description: String) -> [Float32] {
        let triplets = getTriplets(description: description)
        
        var result:[Float32] = [Float32](repeating: 0, count: 27 * 27 * 27)
        for triplet in triplets {
            result[getTripletIndex(triplet: triplet)] = 1
        }
        
        return result
    }
    
    internal func getTriplets(description: String) -> [String] {
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
        
        return result.removeDuplicates()
    }
    
    // x0 + x1 * 27 + x2 * 27
    // 27 = 26 English letters + 1 space
    internal func getTripletIndex(triplet: String) -> Int {
        return getCharacterIndex(char: triplet[0]) +
            getCharacterIndex(char: triplet[1]) * 27 +
            getCharacterIndex(char: triplet[2]) * 27 * 27
    }
    
    internal func getCharacterIndex(char: Character) -> Int {
        return char == " " ? 0 : Int(char.asciiValue!) - ASCII_ACHAR_NUMBER + 1
    }
}
#endif
