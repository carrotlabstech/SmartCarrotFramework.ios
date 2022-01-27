//
//  BudgetAPITest.swift
//  SmartCarrotFrameworkTests
//
//  Copyright © 2020 CarrotLabs gmbh. All rights reserved.
//

import XCTest
@testable import SmartCarrotFramework

class BudgetAPITest: XCTestCase {
    private var persistence = PersistanceType.ephemeral
    private var budgetAPI: BudgetAPI? = nil
    private var transactionAPI : TransactionAPI? = nil
    private var carrotContext = CarrotContext(persistance: .ephemeral)
    
    override func setUp() {
        do {
            carrotContext.setEncryption(key: GlobalsTests.ENCRYPTION_PASSWORD, iv: GlobalsTests.ENCRYPTION_IV)
            try carrotContext.setLicense(license: GlobalsTests.VALID_LICENSE)
            
            transactionAPI = try carrotContext.getTransactionAPI()
            budgetAPI = try carrotContext.getBudgetAPI()
            
            try transactionAPI!.delete(transactions: transactionAPI!.getAll())
            try budgetAPI!.delete(budgets: try budgetAPI!.getAll())
        } catch {
            print(error)
            XCTAssertTrue(false)
        }
    }
    
    private func getBudgets() -> (b1:Budget, b2:Budget, b3:Budget) {
        return APITestData().getBudgets()
    }
    
    private func prepareTxs() throws {
        let result = try APITestData().getTransactionsForBudgeting()
        
        try transactionAPI!.upsert(transactions: result, categorise: false)
    }
    
    private func prepareTxsForRunningTotal() throws {
        let result = APITestData().getTransactionsForBudgetRunningTotal()
        
        try transactionAPI!.upsert(transactions: result, categorise: false)
    }

    func testAddUpdateWithCategorisation() throws {
        let bs = getBudgets()
        try budgetAPI!.upsert(budgets: [bs.b1, bs.b2, bs.b3])
        
        let getAll = try budgetAPI!.getAll()
        
        let index1 = getAll.firstIndex { $0.id == bs.b1.id }!
        let index2 = getAll.firstIndex { $0.id == bs.b2.id }!
        let index3 = getAll.firstIndex { $0.id == bs.b3.id }!
        
        XCTAssertEqual(3, getAll.count)
        XCTAssertEqual(getAll[index1].categoryId, bs.b1.categoryId)
        XCTAssertEqual(getAll[index2].categoryId, bs.b2.categoryId)
        XCTAssertEqual(getAll[index3].categoryId, bs.b3.categoryId)
    }
    
    func testUpsert() throws {
        var bs = getBudgets()
        try budgetAPI!.upsert(budgets: [bs.b1, bs.b2])
        
        let getAll = try budgetAPI!.getAll()
        XCTAssertEqual(2, getAll.count)
        
        bs.b3.id = bs.b1.id
        try budgetAPI!.upsert(budgets: [bs.b3])
        XCTAssertEqual(2, getAll.count)
        
        let getById = try budgetAPI!.getById(id: bs.b3.id)
        XCTAssertEqual(getById!.externalId, bs.b3.externalId)
    }
    
    func testGetAllOrderByName() {
        let bs = getBudgets()
        try? budgetAPI!.upsert(budgets: [bs.b1, bs.b2, bs.b3])
        
        let getAllByName =  try? budgetAPI!.getAllOrderByNameId()
        
        XCTAssertEqual(3, getAllByName!.count)
        XCTAssertEqual(getAllByName![2].name, bs.b1.name)
        XCTAssertEqual(getAllByName![2].id, bs.b1.id)
        XCTAssertEqual(getAllByName![0].name, bs.b2.name)
        XCTAssertEqual(getAllByName![0].id, bs.b2.id)
    }
    
    func testBudgetRunningTotals() throws {
        try prepareTxs()
        
        let bs = getBudgets()
        
        try budgetAPI!.upsert(budgets: [bs.b1, bs.b2, bs.b3])
        
        // montly 2020-02
        var runningTotalB1 = try budgetAPI!.getRunningTotal(budget: bs.b1, year: 2020, month: 02)
        var txCount = try budgetAPI!.getTransactionsCount(budget: bs.b1, year: 2020, month: 02)
        XCTAssertEqual(3, txCount)
        XCTAssertEqual(550, runningTotalB1)
        
        // annual 2020
        txCount = try budgetAPI!.getTransactionsCount(budget: bs.b3, year: 2020, month: 02)
        runningTotalB1 = try budgetAPI!.getRunningTotal(budget: bs.b3, year: 2020, month: 02)
        XCTAssertEqual(4, txCount)
        XCTAssertEqual(1550, runningTotalB1)
        
        // annual 2019
        txCount = try budgetAPI!.getTransactionsCount(budget: bs.b3, year: 2019, month: 01)
        runningTotalB1 = try budgetAPI!.getRunningTotal(budget: bs.b3, year: 2019, month: 02)
        XCTAssertEqual(1, txCount)
        XCTAssertEqual(7, runningTotalB1)
        
        // annual 2018
        txCount = try budgetAPI!.getTransactionsCount(budget: bs.b3, year: 2018, month: 01)
        runningTotalB1 = try budgetAPI!.getRunningTotal(budget: bs.b3, year: 2018, month: 02)
        XCTAssertEqual(0, txCount)
        XCTAssertEqual(0, runningTotalB1)
    }
    
    func testSubcategoriesNotAccountedRunningTotal() throws {
        try prepareTxsForRunningTotal()
        
        let bs = APITestData().getBudgetsForRunningTotal()
        
        XCTAssertEqual(try budgetAPI!.getRunningTotal(budget: bs.b_leisure_shopping), 111)
        XCTAssertEqual(try budgetAPI!.getRunningTotal(budget: bs.b_electronics), 200)
        XCTAssertEqual(try budgetAPI!.getRunningTotal(budget: bs.b_default), 350)
    }
    
    func testLicenseDoesNotHaveModule() {
        let categoriseOnlyContext = CarrotContext(persistance: .ephemeral)
        try? categoriseOnlyContext.setLicense(license: GlobalsTests.CATEGORISE_ONLY_LICENSE)
        let budget = try? categoriseOnlyContext.getBudgetAPI()

        XCTAssertNil(budget)
    }
    
    func testNoBudgetsEmptyList() {
        let budgets = try? budgetAPI!.getAll()
        
        XCTAssertEqual(0, budgets?.count)
    }

}
