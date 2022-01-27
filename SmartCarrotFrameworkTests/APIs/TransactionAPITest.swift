//
//  TransactionAPITest.swift
//  SmartCarrotFrameworkTests
//
//  Copyright © 2020 CarrotLabs gmbh. All rights reserved.
//

import XCTest
@testable import SmartCarrotFramework

class TransactionAPITest: XCTestCase {
    private var carrotContext = CarrotContext()
    private var transactionAPI: TransactionAPI?

    // This is sub-optimal, but there is no one-time exection method, which would have access to the
    // members of the object.
    // Also to keep a similarity to the Android version I keep it like this.
    override func setUp() {
        do {
            carrotContext.setEncryption(key: GlobalsTests.ENCRYPTION_PASSWORD, iv: GlobalsTests.ENCRYPTION_IV)
            try carrotContext.setLicense(license: GlobalsTests.VALID_LICENSE)
            transactionAPI = try carrotContext.getTransactionAPI()
            
            try transactionAPI!.delete(transactions: transactionAPI!.getAll())
        } catch {
            print(error)
            XCTAssertTrue(false)
        }
    }
    
    private func getTransactions() -> (tx1: Transaction, tx2: Transaction, tx3: Transaction) {
        return APITestData().getTransactions()
    }
    
    func testAddUpdateWithCategorisation() throws {
        let txs = getTransactions()
        try transactionAPI!.upsert(transactions: [txs.tx1, txs.tx2, txs.tx3])
        
        let getAll = try transactionAPI!.getAll()
        XCTAssertEqual(3, getAll.count)
        
        let index1 = getAll.firstIndex { $0.id == txs.tx1.id }!
        let index2 = getAll.firstIndex { $0.id == txs.tx2.id }!
        let index3 = getAll.firstIndex { $0.id == txs.tx3.id }!
        
        XCTAssertEqual(getAll[index1].externalId, txs.tx1.externalId)
        XCTAssertEqual(getAll[index2].externalId, txs.tx2.externalId)
        XCTAssertEqual(getAll[index3].externalId, txs.tx3.externalId)
        XCTAssertNotEqual(getAll[index1].categoryId, txs.tx1.categoryId)
        XCTAssertNotEqual(getAll[index2].categoryId, txs.tx2.categoryId)
        XCTAssertNotEqual(getAll[index3].categoryId, txs.tx3.categoryId)
    }
    
    func testUpsert() throws {
        var txs = getTransactions()
        try transactionAPI!.upsert(transactions: [txs.tx1, txs.tx2])
        
        let getAll = try transactionAPI!.getAll()
        XCTAssertEqual(2, getAll.count)
        
        txs.tx3.id = txs.tx1.id
        try transactionAPI!.upsert(transactions: [txs.tx3])
        XCTAssertEqual(2, getAll.count)
        
        let getById = try transactionAPI!.getById(id: txs.tx3.id)
        XCTAssertNotNil(getById)
        XCTAssertEqual(getById!.externalId, txs.tx3.externalId)
    }
    
    func testGetAllOrdered() {
        let txs = getTransactions()
        
        try? transactionAPI!.upsert(transactions: [txs.tx1, txs.tx2, txs.tx3])
        let getAllSorted = try? transactionAPI!.getAllOrderByDateDescTextId()
        
        XCTAssertEqual(getAllSorted!.count, 3)
        XCTAssertEqual(getAllSorted![0].id, txs.tx2.id)
        XCTAssertEqual(getAllSorted![1].id, txs.tx3.id)
        XCTAssertEqual(getAllSorted![2].id, txs.tx1.id)

    }
    
    func testLicenseDoesNotHaveModule() {
        let categoriseOnlyContext = CarrotContext(persistance: .ephemeral)
        try? categoriseOnlyContext.setLicense(license: GlobalsTests.CATEGORISE_ONLY_LICENSE)
        
        let transaction = try? categoriseOnlyContext.getTransactionAPI()

        XCTAssertNil(transaction)
    }
    
    func testNoTransaction() {
        let txn = try? transactionAPI!.getAll()
        
        XCTAssertEqual(txn?.count, 0)
    }
}
