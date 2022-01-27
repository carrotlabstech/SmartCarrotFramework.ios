//
//  BudgetTests.swift
//  SmartCarrotFrameworkTests
//
//  Copyright © 2020 CarrotLabs gmbh. All rights reserved.
//

import XCTest
import SmartCarrotFramework

class BudgetTests: XCTestCase {
    func testNegativeNumbers() {
        let budget = Budget(id: "someid", name: "some name", budgeted: -100, alert: -200, categoryId: -18, frequencyType: .annual)
        
        XCTAssertEqual(budget.budgeted, 0)
        XCTAssertEqual(budget.alert, 0)
        XCTAssertEqual(budget.categoryId, TransactionCategory.UNCATEGORISED_INT_ID)
    }
}
