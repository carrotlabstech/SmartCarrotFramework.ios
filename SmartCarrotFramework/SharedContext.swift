//
//  SharedContext.swift
//  SmartCarrotFramework
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import Foundation

internal class SharedContext {
    internal static let shared = SharedContext()
    
    /// Persistence Key / Password
    internal var key = ""
    
    /// Persistence Initialization Vector
    /// Must be of 16 bytes, the rest is not taken into account
    internal var iv = ""
}
