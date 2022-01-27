//
//  NotificationTest.swift
//  SmartCarrotFrameworkTests
//
//  Copyright © 2020 CarrotLabs gmbh. All rights reserved.
//

import XCTest
@testable import SmartCarrotFramework

class NotificationTest: XCTestCase {
    private var budgetAPI: BudgetAPI?
    private var transactionAPI: TransactionAPI?
    private var carrotContext = CarrotContext()
    
    override func setUp() {
        carrotContext.setEncryption(key: GlobalsTests.ENCRYPTION_PASSWORD, iv: GlobalsTests.ENCRYPTION_IV)
        try? carrotContext.setLicense(license: GlobalsTests.VALID_LICENSE)
        
        transactionAPI = try? carrotContext.getTransactionAPI()
        try? transactionAPI!.delete(transactions: transactionAPI!.getAll())
        
        budgetAPI = try? carrotContext.getBudgetAPI()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testCateforisationFiresTransactionListDidUpdateEvents() throws {
        _ = expectation(forNotification: .transactionListDidUpdate, object: nil, handler: nil)
        
        let txs = try APITestData().getTransactionsForBudgeting()
        try transactionAPI!.upsert(transactions: txs, categorise: false)
        
        waitForExpectations(timeout: 2, handler: nil)
        
        // let's add one more transaction and make sure events are fired consistently
        _ = expectation(forNotification: .transactionListDidUpdate, object: nil, handler: nil)
        let tx = Transaction(id: "yohohoho-id", amount: -900, currency: "CHF", bookingText: "booking sample text", bookingDate: Date())
        try transactionAPI!.upsert(transactions: [tx])
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testBudgetsFireBudgetListDidChangeEvents() throws {
        _ = expectation(forNotification: .budgetListDidUpdate, object: nil, handler: nil)
        
        let budgets = APITestData().getBudgets()
        try budgetAPI!.upsert(budgets: [budgets.b1, budgets.b2])
        
        waitForExpectations(timeout: 2, handler: nil)
        
        _ = expectation(forNotification: .budgetListDidUpdate, object: nil, handler: nil)
        try budgetAPI!.delete(budgets: budgetAPI!.getAll())
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testBudgetAlertEvents() throws {
        let budgets = APITestData().getBudgets()
        try budgetAPI!.upsert(budgets: [budgets.b1])
        
        _ = expectation(forNotification: .budgetDidAlert, object: nil, handler: nil)
        
        let txs = try APITestData().getTransactionsForBudgetingEvents()
        try transactionAPI!.upsert(transactions: txs, categorise: false)
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testBudgetRecalEvents() throws {
        let budgets = APITestData().getBudgets()
        try budgetAPI!.upsert(budgets: [budgets.b2])
        
        _ = expectation(forNotification: .budgetDidOverSpend, object: nil, handler: nil)
        
        let txs = try APITestData().getTransactionsForBudgetingEvents()
        try transactionAPI!.upsert(transactions: txs, categorise: false)
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testBudgetAlertEventsIfBudgetsUpdated() throws {
        let budgets = APITestData().getBudgets()
        try budgetAPI!.upsert(budgets: [budgets.b1])
        
        let txs = try APITestData().getTransactionsForBudgetingEvents()
        try transactionAPI!.upsert(transactions: txs, categorise: false)

        _ = expectation(forNotification: .budgetDidAlert, object: nil, handler: nil)
        
        try budgetAPI!.upsert(budgets: [budgets.b1])

        waitForExpectations(timeout: 2, handler: nil)
    }
}
