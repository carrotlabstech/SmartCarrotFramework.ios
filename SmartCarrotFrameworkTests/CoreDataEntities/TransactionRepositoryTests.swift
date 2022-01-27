//
//  TransactionRepositoryTests.swift
//  SmartCarrotFrameworkTests
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import XCTest
@testable import SmartCarrotFramework

class TransactionRepositoryTests: XCTestCase {
    var repo = TransactionRepository()

    override func setUp() {
        do {
            SharedContext.shared.key = GlobalsTests.ENCRYPTION_PASSWORD
            SharedContext.shared.iv = GlobalsTests.ENCRYPTION_IV
            
            try repo.wipe()
        } catch {
            print("***** failed to truncate tx repository *****")
        }
    }

    override func tearDown() {
        do {
            try repo.wipe()
        } catch {
            XCTAssertTrue(false, "***** failed to truncate tx repository *****")
        }
    }

    func testInsertAndGetById() {
        let minusTenDays = Date(timeIntervalSinceNow: -3600*24*10)
        let minus13Days = Date(timeIntervalSinceNow: -3600*24*13)
        let minus14Days = Date(timeIntervalSinceNow: -3600*24*14)

        do {
            let tx0 = Transaction(id: UUID().uuidString,
                                 externalId: "201",
                                 amount: -100.34,
                                 currency: "CHF",
                                 sourceAmount: -90.12,
                                 sourceCurrency: "EUR",
                                 sourceExchangeRate: 1.12,
                                 bookingText: "this is a great booking text",
                                 bookingDate: minusTenDays,
                                 valueDate: minusTenDays,
                                 categoryId: 45,
                                 userCategoryId: 0,
                                 accountId: "301",
                                 userNote: nil,
                                 customProperty1: "{ value: 100, name: \"ohoho\" }",
                                 customProperty2: "",
                                 created: Date(),
                                 modified: Date())
            let tx1 = Transaction(id: UUID().uuidString,
                                externalId: "202",
                                amount: -1000.00,
                                currency: "CHF",
                                sourceAmount: 0,
                                sourceCurrency: "",
                                sourceExchangeRate: 0,
                                bookingText: "this is a great booking text tx 2",
                                bookingDate: minus13Days,
                                valueDate: minus14Days,
                                categoryId: 101,
                                userCategoryId: 88,
                                accountId: "1301",
                                userNote: "a beautiful transaction tx2",
                                customProperty1: "",
                                customProperty2: "{ value: 10000, name: \"ohoho\" }",
                                created: Date(),
                                modified: Date())
            
            try repo.addUpdate(items: [tx0])
            try repo.addUpdate(items: [tx1])
            let all = try repo.getAll()
            
            XCTAssertEqual(all.count, 2)
            XCTAssertEqual(all[0].id, tx0.id)
            XCTAssertEqual(all[1].id, tx1.id)
            XCTAssertEqual(all[0].bookingDate.timeIntervalSince1970, tx0.bookingDate.timeIntervalSince1970, accuracy: 0.001)
            XCTAssertEqual(all[1].bookingDate.timeIntervalSince1970, tx1.bookingDate.timeIntervalSince1970, accuracy: 0.001)
            XCTAssertNotEqual(tx0.id, tx1.id)
            XCTAssertEqual(all[0].customProperty1, tx0.customProperty1)
            XCTAssertEqual(all[1].customProperty2, tx1.customProperty2)
            XCTAssertEqual(all[0].sourceCurrency, tx0.sourceCurrency)
            XCTAssertEqual(all[1].sourceCurrency, tx1.sourceCurrency)
            XCTAssertEqual(all[0].accountId, tx0.accountId)
            XCTAssertEqual(all[1].accountId, tx1.accountId)
            XCTAssertNil(all[0].userNote)
            
            // Check By Id predicate
            var getById = try repo.getById(id: tx1.id)
            XCTAssertNotNil(getById)
            XCTAssertEqual(tx1.id, getById!.id)
            
            getById = try repo.getById(id: "random non-existing string")
            XCTAssertNil(getById)
        } catch {
            print("****** error *****")
        }
    }
    
    func testGetById() throws {
        
    }
    
    func testOptionals() throws {
        let tx1 = Transaction(id: UUID().uuidString,
            externalId: "202",
            amount: -1000.00,
            currency: "CHF",
            sourceAmount: nil,
            sourceCurrency: nil,
            sourceExchangeRate: nil,
            bookingText: "this is a great booking text tx 2",
            bookingDate: Date(timeIntervalSinceNow: -3600*24*13),
            valueDate: Date(timeIntervalSinceNow: -3600*24*14),
            categoryId: nil,
            userCategoryId: nil,
            accountId: "1301",
            userNote: nil,
            customProperty1: nil,
            customProperty2: nil,
            created: Date(),
            modified: Date())
        
        try repo.addUpdate(items: [tx1])
        let all = try repo.getAll()
        
        XCTAssertNil(all[0].sourceAmount)
        XCTAssertNil(all[0].sourceCurrency)
        XCTAssertNil(all[0].userNote)
    }
    
    func testUpSert() throws {
        let id1 = UUID().uuidString
        
        let tx1 = Transaction(id: id1,
            externalId: "100",
            amount: -1000.00,
            currency: "CHF",
            sourceAmount: nil,
            sourceCurrency: nil,
            sourceExchangeRate: nil,
            bookingText: "this is a great booking text tx 2",
            bookingDate: Date(timeIntervalSinceNow: -3600*24*13),
            valueDate: Date(timeIntervalSinceNow: -3600*24*14),
            categoryId: nil,
            userCategoryId: nil,
            accountId: "1301",
            userNote: nil,
            customProperty1: nil,
            customProperty2: nil,
            created: Date(),
            modified: Date())

        let tx2 = Transaction(id: id1,
            externalId: "500",
            amount: -10000.00,
            currency: "CHF",
            sourceAmount: 0,
            sourceCurrency: "",
            sourceExchangeRate: 0,
            bookingText: "this is a great booking text tx 2",
            bookingDate: Date(timeIntervalSinceNow: -3600*24*13),
            valueDate: Date(timeIntervalSinceNow: -3600*24*14),
            categoryId: 101,
            userCategoryId: 88,
            accountId: "1301",
            userNote: "a beautiful transaction tx2",
            customProperty1: "",
            customProperty2: "{ value: 10000, name: \"ohoho\" }",
            created: Date(),
            modified: Date())
        
        let tx3 = Transaction(id: UUID().uuidString,
            externalId: "1500",
            amount: -10000.00,
            currency: "CHF",
            sourceAmount: 0,
            sourceCurrency: "",
            sourceExchangeRate: 0,
            bookingText: "this is a great booking text tx 2",
            bookingDate: Date(timeIntervalSinceNow: -3600*24*13),
            valueDate: Date(timeIntervalSinceNow: -3600*24*14),
            categoryId: 101,
            userCategoryId: 88,
            accountId: "1301",
            userNote: "a beautiful transaction tx2",
            customProperty1: "",
            customProperty2: "{ value: 10000, name: \"ohoho\" }",
            created: Date(),
            modified: Date())
        
        try repo.addUpdate(items: [tx1])
        try repo.addUpdate(items: [tx2])
        try repo.addUpdate(items: [tx3])
        
        let allTxs = try repo.getAll()
        XCTAssertEqual(allTxs.count, 2)
        XCTAssertEqual(allTxs[0].externalId, tx2.externalId)
        XCTAssertEqual(allTxs[1].externalId, tx3.externalId)
        XCTAssertEqual(allTxs[0].id, id1)
        XCTAssertEqual(allTxs[1].id, tx3.id)

    }
    
    func testAddUpdateFewItems() throws {
        let tx1 = Transaction(id: UUID().uuidString,
            externalId: "100",
            amount: -1000.00,
            currency: "CHF",
            sourceAmount: nil,
            sourceCurrency: nil,
            sourceExchangeRate: nil,
            bookingText: "this is a great booking text tx 2",
            bookingDate: Date(timeIntervalSinceNow: -3600*24*13),
            valueDate: Date(timeIntervalSinceNow: -3600*24*14),
            categoryId: nil,
            userCategoryId: nil,
            accountId: "1301",
            userNote: nil,
            customProperty1: nil,
            customProperty2: nil,
            created: Date(),
            modified: Date())

        let tx2 = Transaction(id: UUID().uuidString,
            externalId: "500",
            amount: -10000.00,
            currency: "CHF",
            sourceAmount: 0,
            sourceCurrency: "",
            sourceExchangeRate: 0,
            bookingText: "this is a great booking text tx 2",
            bookingDate: Date(timeIntervalSinceNow: -3600*24*13),
            valueDate: Date(timeIntervalSinceNow: -3600*24*14),
            categoryId: 101,
            userCategoryId: 88,
            accountId: "1301",
            userNote: "a beautiful transaction tx2",
            customProperty1: "",
            customProperty2: "{ value: 10000, name: \"ohoho\" }",
            created: Date(),
            modified: Date())
        
        let tx3 = Transaction(id: UUID().uuidString,
            externalId: "1500",
            amount: -10000.00,
            currency: "CHF",
            sourceAmount: 0,
            sourceCurrency: "",
            sourceExchangeRate: 0,
            bookingText: "this is a great booking text tx 2",
            bookingDate: Date(timeIntervalSinceNow: -3600*24*13),
            valueDate: Date(timeIntervalSinceNow: -3600*24*14),
            categoryId: 101,
            userCategoryId: 88,
            accountId: "1301",
            userNote: "a beautiful transaction tx2",
            customProperty1: "",
            customProperty2: "{ value: 10000, name: \"ohoho\" }",
            created: Date(),
            modified: Date())
        
        try repo.addUpdate(items: [tx1, tx2, tx3])
        
        let allTxs = try repo.getAll()
        XCTAssertEqual(allTxs.count, 3)
    }
    
    func testThrowEmptyId() {
        var tx = Transaction()
        let tx1 = Transaction()
        
        tx.id = "something"
        XCTAssertThrowsError(try repo.addUpdate(items: [tx, tx1]))
    }
}
