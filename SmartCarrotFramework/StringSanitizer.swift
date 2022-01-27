//
//  StringSanitizer.swift
//  SmartCarrotFramework
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import Foundation

internal class StringSanitizer {
    static func cleanseString(arg: String) -> String {
        var result = arg.lowercased()
        
        result = result.replacingOccurrences(of: "(\\s+)?&(\\s+)?", with: "xqzptx", options: .regularExpression)
        result = result.replacingOccurrences(of: "[0-9]+", with: "", options: .regularExpression)
        result = result.replacingOccurrences(of: "\\.", with: " ", options: .regularExpression)
        result = result.replacingOccurrences(of: "ü", with: "ue", options: .regularExpression)
        result = result.replacingOccurrences(of: "ä", with: "ae", options: .regularExpression)
        result = result.replacingOccurrences(of: "ö", with: "oe", options: .regularExpression)
        result = result.replacingOccurrences(of: "é|è|ê|ë", with: "e", options: .regularExpression)
        result = result.replacingOccurrences(of: "à|â", with: "a", options: .regularExpression)
        result = result.replacingOccurrences(of: "ô", with: "o", options: .regularExpression)
        result = result.replacingOccurrences(of: "û", with: "u", options: .regularExpression)
        result = result.replacingOccurrences(of: "ï|î", with: "i", options: .regularExpression)
        result = result.replacingOccurrences(of: "ç", with: "c", options: .regularExpression)
        result = result.replacingOccurrences(of: "\\.|-|_|\\s+", with: " ", options: .regularExpression)
        result = result.replacingOccurrences(of: "\\|", with: "", options: .regularExpression)
        
        // this should leave only ASCII chars in the string
        result = result.replacingOccurrences(of: "[^a-z| ]", with: "", options: .regularExpression)
        
        while result != result.replacingOccurrences(of: " [a-z]{1} | [a-z]{1}$|^[a-z]{1} ", with: " ", options: .regularExpression) {
            result = result.replacingOccurrences(of: " [a-z]{1} | [a-z]{1}$|^[a-z]{1} ", with: " ", options: .regularExpression)
        }
        
        result = result.replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression)
        result = result.replacingOccurrences(of: "^\\s+|\\s+$", with: "", options: .regularExpression)
        
        result = result.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return result
    }
}
