//
//  ZenTests.swift
//  SmartCarrotFrameworkTests
//
//  Copyright © 2020 CarrotLabs gmbh. All rights reserved.
//

import XCTest
@testable import SmartCarrotFramework

class ZenTests: XCTestCase {
    internal let _eps: Decimal = 0.0001
    internal let _zenTestData = ZenTestData()

    func testSpendingMatrix() {
        let zenBuilder = Zen(transactions: _zenTestData.Transactions, budgets: _zenTestData.Budgets)
        
        let spendingMatrix = zenBuilder.buildSpendingMatrix()
        
        for i in 0...spendingMatrix.count - 1 {
            for j in 0...spendingMatrix[i].count - 1 {
                XCTAssertEqual(spendingMatrix[i][j], _zenTestData.SpendingMatrix[i][j])
            }
        }

        // Control check :)
        XCTAssertEqual(spendingMatrix[0][1], _zenTestData.SpendingMatrix[0][1])
    }
    
    func testUtilisationMatrix() {
        let zenBuilder = Zen(transactions: _zenTestData.Transactions, budgets: _zenTestData.Budgets)

        let spendingMatrix = zenBuilder.buildSpendingMatrix()
        let utilisationMatrix = zenBuilder.buildUtilisationMatrix(spendingMatrix: spendingMatrix)
        
        for i in 0...utilisationMatrix.count - 1 {
            for j in 0...utilisationMatrix[i].count - 1 {
                XCTAssertLessThan(abs(utilisationMatrix[i][j] - _zenTestData.UtilisationMatrix[i][j]), _eps)
            }
        }
        
        // Control check
        XCTAssertEqual(utilisationMatrix[0][1], _zenTestData.UtilisationMatrix[0][1])
    }
    
    func testBuild() {
        let zenBuilder = Zen(transactions: _zenTestData.Transactions, budgets: _zenTestData.Budgets)

        let outputFrame: [ZenItem] = zenBuilder.buildOutputFrame()
        
        for i in 0...outputFrame.count - 1 {
            XCTAssertEqual(outputFrame[i], _zenTestData.ZenItemsMid[i])
        }

        // control check ))
        XCTAssertEqual(outputFrame[0], _zenTestData.ZenItemsMid[0])
    }
    
    func testBuildUnbudgetedSpendingVector() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let transactions = [ Transaction(id: "1-1", amount: -101, currency: "CHF", bookingText: "text", bookingDate: dateFormatter.date(from: "2010-01-20")!, categoryId: 50),
                            Transaction(id: "1-2", amount: -102, currency: "CHF", bookingText: "text", bookingDate: dateFormatter.date(from: "2010-01-20")!, categoryId: 77),
                            Transaction(id: "1-3", amount: -103, currency: "CHF", bookingText: "text", bookingDate: dateFormatter.date(from: "2010-01-20")!, categoryId: nil),
                            Transaction(id: "2-1", amount: -103, currency: "CHF", bookingText: "text", bookingDate: dateFormatter.date(from: "2010-01-21")!, categoryId: nil),
                            Transaction(id: "3-1", amount: -222, currency: "CHF", bookingText: "text", bookingDate: dateFormatter.date(from: "2010-01-22")!, categoryId: 50),
                            Transaction(id: "3-1", amount: -111, currency: "CHF", bookingText: "text", bookingDate: dateFormatter.date(from: "2010-01-22")!, categoryId: 100),
        ]
        
        let budgets = [ Budget(id: "1", name: "one", budgeted: 1000, alert: 80, categoryId: 50, frequencyType: BudgetFrequency.monthly),
            Budget(id: "2", name: "one", budgeted: 1000, alert: 80, categoryId: 100, frequencyType: BudgetFrequency.monthly)]
        
        let zenBuilder = Zen(transactions: transactions, budgets: budgets)
        let unspent = zenBuilder.buildUnbudgetedSpendingVector()
        
        XCTAssertEqual(unspent.count, 3)
        XCTAssertEqual(unspent[0], 205)
        XCTAssertEqual(unspent[1], 103)
        XCTAssertEqual(unspent[2], 0)
        
    }
    
    func testBuildZen() {
        let zenBuilder = Zen(transactions: _zenTestData.Transactions, budgets: _zenTestData.Budgets)
        
        let outputFrame = zenBuilder.buildOutputFrame()
        let incomeVector = zenBuilder.buildIncomeVector()
        
        let zen = zenBuilder.buildZen(outputFrame: outputFrame, incomeVector: incomeVector)
        
        
        XCTAssertEqual(zen.count, _zenTestData.ZenItemsFull.count)
        
        for i in 0...zen.count - 1 {
            XCTAssertEqual(zen[i].DaySince1970, _zenTestData.ZenItemsFull[i].DateSince1970)
//            XCTAssertLessThan(abs(zen[i].Score - _zenTestData.ZenItemsFull[i].ZenScore), _eps)
            XCTAssertTrue(abs(zen[i].Score - _zenTestData.ZenItemsFull[i].ZenScore) < _eps)
        }
    }
    
    func testBuildZenFull() {
        let zenBuilder = Zen(transactions: _zenTestData.Transactions, budgets: _zenTestData.Budgets)
        let zen = zenBuilder.build()
        
        XCTAssertEqual(zen.count, _zenTestData.ZenItemsFull.count)
        
        for i in 0...zen.count - 1 {
            XCTAssertEqual(zen[i].DaySince1970, _zenTestData.ZenItemsFull[i].DateSince1970)
            XCTAssertLessThan(abs(zen[i].Score - _zenTestData.ZenItemsFull[i].ZenScore), _eps)
        }
    }
    
    func testMaxCalcInterval() {
        
    }
}
