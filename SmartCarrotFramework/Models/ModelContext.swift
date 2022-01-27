//
//  ModelContext.swift
//  SmartCarrotFramework
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import Foundation

internal class ModelContext {
    internal static let BUNDLE_IDENTIFIER = "c".a.r.r.o.t.l.a.b.s.dot.S.m.a.r.t.C.a.r.r.o.t.F.r.a.m.e.w.o.r.k  // "carrotlabs.SmartCarrotFramework"

#if COUNTRY_US
    // US Threshold
    internal static let CERTAINTY_THRESHOLD:Float32 = 0.075

#elseif COUNTRY_CH
    // CH Threshold
    internal static let CERTAINTY_THRESHOLD:Float32 = 0.175
    
#endif
}
