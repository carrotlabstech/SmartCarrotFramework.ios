//
//  Extensions.swift
//  OutlabFramework
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import Foundation

internal extension Data {
    /// Creates a new buffer by copying the buffer pointer of the given array.
    ///
    /// - Warning: The given array's element type `T` must be trivial in that it can be copied bit
    ///     for bit with no indirection or reference-counting operations; otherwise, reinterpreting
    ///     data from the resulting buffer has undefined behavior.
    /// - Parameter array: An array with elements of type `T`.
    init<T>(copyingBufferOf array: [T]) {
        self = array.withUnsafeBufferPointer(Data.init)
    }
}

internal extension Decimal {
    var doubleValue:Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}

internal extension String {
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    subscript(index: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: index)]   
    }
    
    var parseJSONString: Any? {
        let data = self.data(using: .utf8, allowLossyConversion: false)

        if let jsonData = data {
            // Will return an object or nil if JSON decoding fails
            let result: Any?
            do {
                result = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
            } catch {
                result = nil
            }
            
            return result
        } else {
            // Lossless conversion of the string was not possible
            return nil
        }
    }
}

internal extension Array {
    /// Creates a new array from the bytes of the given unsafe data.
    ///
    /// - Warning: The array's `Element` type must be trivial in that it can be copied bit for bit
    ///     with no indirection or reference-counting operations; otherwise, copying the raw bytes in
    ///     the `unsafeData`'s buffer to a new array returns an unsafe copy.
    /// - Note: Returns `nil` if `unsafeData.count` is not a multiple of
    ///     `MemoryLayout<Element>.stride`.
    /// - Parameter unsafeData: The data containing the bytes to turn into an array.
    init?(unsafeData: Data) {
        guard unsafeData.count % MemoryLayout<Element>.stride == 0 else { return nil }
        #if swift(>=5.0)
        self = unsafeData.withUnsafeBytes { .init($0.bindMemory(to: Element.self)) }
        #else
        self = unsafeData.withUnsafeBytes {
            .init(UnsafeBufferPointer<Element>(
                start: $0,
                count: unsafeData.count / MemoryLayout<Element>.stride
            ))
        }
        #endif  // swift(>=5.0)
    }
}

internal extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        
        for value in self {
            if !result.contains(value) {
                result.append(value)
            }
        }
        
        return result
    }
}

// The extension returns nil if the array is empty.
//
// Else, it starts by assuming the first value is the max, iterates over all values,
// updates the index and value to any larger values found, and finally returns the result.
internal extension Array where Element: Comparable {
    var indexOfMax: Index? {
        guard var maxValue = self.first else { return nil }
        var maxIndex = 0
        
        for (index, value) in self.enumerated() {
            if value > maxValue {
                maxValue = value
                maxIndex = index
            }
        }
        
        return maxIndex
    }
}

internal extension DateFormatter {
    /// Returns formatter to produce the output format as "yyyy-MM-dd HH:mm:ss"
    /// Made more complicated on purpose because it is used by the hashing algorightm
    func LongDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        let partOne = "yyyy-M"
        let partTwo = "M-dd HH:mm:ss"
        dateFormatter.dateFormat = partOne + partTwo
        return dateFormatter
    }
}
