//
//  BudgetRepositoryTest.swift
//  SmartCarrotFrameworkTests
//
//  Copyright © 2020 CarrotLabs gmbh. All rights reserved.
//

import XCTest
@testable import SmartCarrotFramework

class BudgetRepositoryTest : XCTestCase {
    var repo = BudgetRepository()

    override func setUp() {
        do {
            try repo.wipe()
        } catch {
            print("***** failed to truncate tx repository *****")
        }
    }

    override func tearDown() {
        do {
            try repo.wipe()
        } catch {
            print("***** failed to truncate tx repository *****")
        }
    }
    
    func testInsert() {
        SharedContext.shared.key = "pa$$word"
        SharedContext.shared.iv = "GKVHJVKLFAKLJFHLFHXHNLKnjksdfkjd"

        do {
            let b0 = Budget(id: UUID().uuidString,
                             externalId: "201",
                             name: "sweets",
                             budgeted: 100,
                             alert: 80,
                             categoryId: 100,
                             frequencyType: .monthly)
            let b1 = Budget(id: UUID().uuidString,
                            externalId: "201",
                            name: "houses",
                            budgeted: 100,
                            alert: 90,
                            categoryId: 10,
                            frequencyType: .annual)
            
            try repo.addUpdate(items: [b0])
            try repo.addUpdate(items: [b1])
            let all = try repo.getAll()
            
            XCTAssertEqual(all.count, 2)
            XCTAssertEqual(all[0].id, b0.id)
            XCTAssertEqual(all[1].id, b1.id)
            XCTAssertEqual(all[0].frequencyType, b0.frequencyType)
            XCTAssertEqual(all[1].frequencyType, b1.frequencyType)
            XCTAssertNotEqual(b0.id, b1.id)
            XCTAssertEqual(all[0].name, b0.name)
            XCTAssertEqual(all[1].name, b1.name)
            XCTAssertEqual(all[0].budgeted, b0.budgeted)
            XCTAssertEqual(all[1].budgeted, b1.budgeted)
            XCTAssertEqual(all[0].externalId, b0.externalId)
            XCTAssertEqual(all[1].externalId, b1.externalId)
            XCTAssertEqual(all[0].alert, b0.alert)
            XCTAssertEqual(all[1].alert, b1.alert)
            
            // Check By Id predicate
            var getById = try repo.getById(id: b1.id)
            XCTAssertEqual(b1.id, getById!.id)
            
            getById = try repo.getById(id: "random non-existing string")
            XCTAssertNil(getById)
        } catch {
            print("****** error *****")
        }
    }
    
    func testOptionals() throws {
        SharedContext.shared.key = "pa$$word"
        SharedContext.shared.iv = "GKVHJVKLFAKLJFHLFHXHNLKnjksdfkjd"
        
        let b0 = Budget(id: UUID().uuidString,
            externalId: nil,
            name: "name",
            budgeted: 1000.00,
            alert: 1000.00,
            categoryId: 10,
            frequencyType: .annual)
        
        try repo.addUpdate(items: [b0])
        let all = try repo.getAll()
        
        XCTAssertNil(all[0].externalId)
        XCTAssertNotNil(all[0].budgeted)
    }

    func testUpSert() throws {
        SharedContext.shared.key = "pa$$word"
        SharedContext.shared.iv = "GKVHJVKLFAKLJFHLFHXHNLKnjksdfkjd"

        let id1 = UUID().uuidString
        
        let b0 = Budget(id: id1,
                         externalId: "201",
                         name: "sweets",
                         budgeted: 100,
                         alert: 80,
                         categoryId: 100,
                         frequencyType: .monthly)
        let b1 = Budget(id: id1,
                        externalId: "211",
                        name: "houses",
                        budgeted: 100,
                        alert: 90,
                        categoryId: 10,
                        frequencyType: .annual)
        
        let b2 = Budget(id: UUID().uuidString,
            externalId: "221",
            name: "horses",
            budgeted: 10000,
            alert: 90,
            categoryId: 88,
            frequencyType: .annual)
        
        
        try repo.addUpdate(items: [b0])
        try repo.addUpdate(items: [b1])
        try repo.addUpdate(items: [b2])
        
        let allBudgets = try repo.getAll()
        
        XCTAssertEqual(allBudgets.count, 2)
        XCTAssertEqual(allBudgets[0].externalId, b1.externalId)
        XCTAssertEqual(allBudgets[1].externalId, b2.externalId)
        XCTAssertEqual(allBudgets[0].id, id1)
        XCTAssertEqual(allBudgets[1].id, b2.id)

    }

    func testAddUpdateFewItems() throws {
            SharedContext.shared.key = "pa$$word"
            SharedContext.shared.iv = "GKVHJVKLFAKLJFHLFHXHNLKnjksdfkjd"

            
            let b0 = Budget(id: UUID().uuidString,
                             externalId: "201",
                             name: "sweets",
                             budgeted: 100,
                             alert: 80,
                             categoryId: 100,
                             frequencyType: BudgetFrequency.monthly)
            let b1 = Budget(id: UUID().uuidString,
                            externalId: "211",
                            name: "houses",
                            budgeted: 100,
                            alert: 90,
                            categoryId: 10,
                            frequencyType: .annual)
            
            let b2 = Budget(id: UUID().uuidString,
                externalId: "221",
                name: "horses",
                budgeted: 10000,
                alert: 90,
                categoryId: 88,
                frequencyType: .annual)
            
            try repo.addUpdate(items: [b0, b1, b2])
            
            let allB = try repo.getAll()
            XCTAssertEqual(allB.count, 3)
        }
    }
