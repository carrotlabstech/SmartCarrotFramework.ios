//
//  Allocation.swift
//  SmartCarrotFramework
//
//  Copyright © 2020 CarrotLabs gmbh. All rights reserved.
//

import Foundation

internal struct Allocation : EntityWithId {
    public var id: String
    public var categoryId: Int
    public var date: Date
    public var amount: Decimal
}
