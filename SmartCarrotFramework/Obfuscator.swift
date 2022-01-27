//
//  Obfuscator.swift
//  SmartCarrotFramework
//
//  Copyright © 2020 CarrotLabs gmbh. All rights reserved.
//

import Foundation

internal class Obfuscator {
    
    // MARK: - Variables
    
    /// The salt used to obfuscate and reveal the string.
    private var salt: String
    
    // MARK: - Initialization
    
    init(with salt: String) {
        self.salt = salt
    }
    
    
    // MARK: - Instance Methods
    
    /**
     This method obfuscates the string passed in using the salt
     that was used when the Obfuscator was initialized.
     
     - parameter string: the string to obfuscate
     
     - returns: the obfuscated string in a byte array
     */
    internal func bytesByObfuscatingString(string: String) -> [UInt8] {
        let text = [UInt8](string.utf8)
        let cipher = [UInt8](self.salt.utf8)
        let length = cipher.count
        
        var encrypted = [UInt8]()
        
        for t in text.enumerated() {
            encrypted.append(t.element ^ cipher[t.offset % length])
        }
        
        return encrypted
    }
    
    /**
     This method reveals the original string from the obfuscated
     byte array passed in. The salt must be the same as the one
     used to encrypt it in the first place.
     
     - parameter key: the byte array to reveal
     
     - returns: the original string
     */
    internal func reveal(key: [UInt8]) -> String {
        let cipher = [UInt8](self.salt.utf8)
        let length = cipher.count
        
        var decrypted = [UInt8]()
        
        for k in key.enumerated() {
            decrypted.append(k.element ^ cipher[k.offset % length])
        }
        
        return String(bytes: decrypted, encoding: .utf8)!
    }
}

// MARK: - a-z -
internal extension String {
    var a: String { return self + "a" }
    var b: String { return self + "b" }
    var c: String { return self + "c" }
    var d: String { return self + "d" }
    var e: String { return self + "e" }
    var f: String { return self + "f" }
    var g: String { return self + "g" }
    var h: String { return self + "h" }
    var i: String { return self + "i" }
    var j: String { return self + "j" }
    var k: String { return self + "k" }
    var l: String { return self + "l" }
    var m: String { return self + "m" }
    var n: String { return self + "n" }
    var o: String { return self + "o" }
    var p: String { return self + "p" }
    var q: String { return self + "q" }
    var r: String { return self + "r" }
    var s: String { return self + "s" }
    var t: String { return self + "t" }
    var u: String { return self + "u" }
    var v: String { return self + "v" }
    var w: String { return self + "w" }
    var x: String { return self + "x" }
    var y: String { return self + "y" }
    var z: String { return self + "z" }
}

// MARK: - A-Z -
internal extension String {
    var A: String { return self + "A" }
    var B: String { return self + "B" }
    var C: String { return self + "C" }
    var D: String { return self + "D" }
    var E: String { return self + "E" }
    var F: String { return self + "F" }
    var G: String { return self + "G" }
    var H: String { return self + "H" }
    var I: String { return self + "I" }
    var J: String { return self + "J" }
    var K: String { return self + "K" }
    var L: String { return self + "L" }
    var M: String { return self + "M" }
    var N: String { return self + "N" }
    var O: String { return self + "O" }
    var P: String { return self + "P" }
    var Q: String { return self + "Q" }
    var R: String { return self + "R" }
    var S: String { return self + "S" }
    var T: String { return self + "T" }
    var U: String { return self + "U" }
    var V: String { return self + "V" }
    var W: String { return self + "W" }
    var X: String { return self + "X" }
    var Y: String { return self + "Y" }
    var Z: String { return self + "Z" }
}

// MARK: - Numbers -
internal extension String {
    var _1: String { return self + "1" }
    var _2: String { return self + "2" }
    var _3: String { return self + "3" }
    var _4: String { return self + "4" }
    var _5: String { return self + "5" }
    var _6: String { return self + "6" }
    var _7: String { return self + "7" }
    var _8: String { return self + "8" }
    var _9: String { return self + "9" }
    var _0: String { return self + "0" }
}

// MARK: - Punctuation -
internal extension String {
    var space: String { return self + " " }
    var point: String { return self + "." }
    var dash: String { return self + "-" }
    var comma: String { return self + "," }
    var semicolon: String { return self + ";" }
    var colon: String { return self + ":" }
    var apostrophe: String { return self + "'" }
    var quotation: String { return self + "\"" }
    var plus: String { return self + "+" }
    var equals: String { return self + "=" }
    var paren_left: String { return self + "(" }
    var paren_right: String { return self + ")" }
    var asterisk: String { return self + "*" }
    var ampersand: String { return self + "&" }
    var caret: String { return self + "^" }
    var percent: String { return self + "%" }
    var `$`: String { return self + "$" }
    var pound: String { return self + "#" }
    var at: String { return self + "@" }
    var exclamation: String { return self + "!" }
    var question_mark: String { return self + "?" }
    var back_slash: String { return self + "\\" }
    var forward_slash: String { return self + "/" }
    var curly_left: String { return self + "{" }
    var curly_right: String { return self + "}" }
    var bracket_left: String { return self + "[" }
    var bracket_right: String { return self + "]" }
    var bar: String { return self + "|" }
    var less_than: String { return self + "<" }
    var greater_than: String { return self + ">" }
    var underscore: String { return self + "_" }
}

// MARK: - Aliases -
internal extension String {
    var dot: String { return point }
}
