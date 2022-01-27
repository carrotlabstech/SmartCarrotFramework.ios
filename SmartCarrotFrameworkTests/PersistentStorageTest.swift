//
//  PersistentStorageTest.swift
//  SmartCarrotFrameworkTests
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import XCTest
@testable import SmartCarrotFramework

class PersistentStorageTest : XCTestCase {
    let children =     TransactionCategory("children").getIntId()
    let traffic_fine = TransactionCategory("traffic_fine").getIntId()
    let alimony =      TransactionCategory("alimony").getIntId()
    let groceries =    TransactionCategory("groceries").getIntId()
    
    override func tearDown() {
        PersistentStorage.shared().reset()
        
        do {
            try PersistentStorage.shared().save(persistance: .persistent)
        } catch {
            print(error)
        }
    }
    
    func testSave() {
        learn()
        
        let storage = PersistentStorage.shared().load(persistance: .persistent)
        
        XCTAssertGreaterThan(storage.densityMatrix.count, 0)
        XCTAssertGreaterThan(storage.dictionary.count, 0)
        XCTAssertGreaterThan(storage.weightsMatix.count, 0)
        XCTAssertGreaterThan(storage.wordDictionary.count, 0)
    }
    
    func testReset() {
        // train model and make sure it takes categorization into account
        learn()
        
        let model = MasterModel(persistance: .persistent)
        var categoryId = model!.categorise(transactionDescription: "Stadt Bülach trx number 400", transactionAmount: -1600, personal: .personal)
        
        XCTAssertEqual(children, categoryId)
        
        // reset model and make sure personalization has gone
        tearDown()
        model!.load()
        
        categoryId = model!.categorise(transactionDescription: "Stadt Bülach trx number 400", transactionAmount: -1600, personal: .personal)
        let nonPersonalCategoryId = model!.categorise(transactionDescription: "Stadt Bülach trx number 400", transactionAmount: -1600, personal: .nonPersonal)
        
        XCTAssertEqual(nonPersonalCategoryId, categoryId)
        XCTAssertNotEqual(children, categoryId)
    }
    
    func learn() {
        let model = MasterModel(persistance: .persistent)
        
        do {
            try model!.learn(transactionDescription: "Stadt Bülach trx number 400", transactionAmount: -1600, personalCategoryId: children)
            try model!.learn(transactionDescription: "Stadt Bülach trx number 401", transactionAmount: -30, personalCategoryId: traffic_fine)
            try model!.learn(transactionDescription: "Binkys stupid money transfer again", transactionAmount: -1400, personalCategoryId: alimony)
            try model!.learn(transactionDescription: "bp station", transactionAmount: -12, personalCategoryId: groceries)
        } catch {
            print(error)
        }
    }
}
