//
//  ZenAPITest.swift
//  SmartCarrotFrameworkTests
//
//  Copyright © 2020 CarrotLabs gmbh. All rights reserved.
//

import XCTest
@testable import SmartCarrotFramework

class ZenAPITest: XCTestCase {

    private var budgetAPI: BudgetAPI? = nil
    private var transactionAPI: TransactionAPI? = nil
    private var zenAPI: ZenAPI? = nil
    private var carrotContext: CarrotContext = CarrotContext(persistance: .ephemeral)
    
    override func setUp() {
        do {
            carrotContext.setEncryption(key: GlobalsTests.ENCRYPTION_PASSWORD, iv: GlobalsTests.ENCRYPTION_IV)
            try carrotContext.setLicense(license: GlobalsTests.VALID_LICENSE)
            
            transactionAPI = try carrotContext.getTransactionAPI()
            budgetAPI = try carrotContext.getBudgetAPI()
            zenAPI = try carrotContext.getZenAPI()

            try budgetAPI!.delete(budgets: budgetAPI!.getAll())
            try transactionAPI!.delete(transactions: transactionAPI!.getAll())
        } catch {
            print(error)
            XCTAssertTrue(false)
        }
    }
    
    func testNoBudget() throws {
        let tx1 = Transaction(id: UUID().uuidString,
            amount: -111,
            currency: "CHF",
            bookingText: "this is a great booking text",
            bookingDate: Date(timeIntervalSince1970: 0),
            categoryId: TransactionCategory.init("leisure_shopping").getIntId())
        
        try transactionAPI!.upsert(transactions: [tx1])
        
        XCTAssertThrowsError(try zenAPI!.buildZen())
    }
    
    func testMaxInterval() {
        var txs = [Transaction]()
        
        var tx1 = Transaction(id: UUID().uuidString,
            amount: -111,
            currency: "CHF",
            bookingText: "this is a great booking text",
            bookingDate: Date(timeIntervalSince1970: 0),
            categoryId: TransactionCategory.init("leisure_shopping").getIntId())
        txs.append(tx1)
        
        tx1 = Transaction(id: UUID().uuidString,
            amount: -200,
            currency: "CHF",
            bookingText: "this is a great booking text",
            bookingDate: Date(timeIntervalSince1970: 30 * 365 * 24 * 3600),
            categoryId: TransactionCategory.init("electronics").getIntId())
        txs.append(tx1)
        
        tx1 = Transaction(id: UUID().uuidString,
            amount: -350,
            currency: "CHF",
            bookingText: "this is a great booking text",
            bookingDate: Date(),
            categoryId: TransactionCategory.UNCATEGORISED_INT_ID)
        txs.append(tx1)
        
        try? transactionAPI!.upsert(transactions: txs)
        
        let bs = APITestData().getBudgets()
        try? budgetAPI!.upsert(budgets: [bs.b1, bs.b2])
        
        let zen = try? zenAPI!.buildZen()
        XCTAssertLessThanOrEqual(zen!.count, ZenParams.MAX_INTERVAL + 1)
        
        XCTAssertEqual(zen![zen!.count - 1].DaySince1970, ZenUtils.daySince1970(date: Date()))
    }
    
    func testLicenseDoesNotHaveModule() {
        let context = CarrotContext(persistance: .ephemeral)
        try? context.setLicense(license: GlobalsTests.CATEGORISE_ONLY_LICENSE)
        
        let zen = try? context.getZenAPI()

        XCTAssertNil(zen)
    }
}
