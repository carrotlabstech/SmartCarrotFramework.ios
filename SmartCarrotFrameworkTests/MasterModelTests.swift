//
//  MasterModelTests.swift
//  SmartCarrotFrameworkTests
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import XCTest
@testable import SmartCarrotFramework

class MasterModelTests : XCTestCase {
    func testRunModel() {
        let model = MasterModel(persistance: .ephemeral, weightTensor:  GlobalsTests.WEIGHT_TENSOR)
        
        XCTAssertEqual(model!.categorise(transactionDescription: "coop tankstelle", transactionAmount: -100, personal: .nonPersonal), 80) // gas
        XCTAssertEqual(model!.categorise(transactionDescription: "coop Paradeplatz", transactionAmount: -100, personal: .nonPersonal), 24) // groceries
    }
    
    func testEmptyTransaction() {
        let model = MasterModel(persistance: .ephemeral, weightTensor: GlobalsTests.WEIGHT_TENSOR)
        
        XCTAssertEqual(model!.categorise(transactionDescription: "", transactionAmount: 0, personal: .personal), TransactionCategory.UNCATEGORISED.getIntId())
    }
    
    func testBpStation() {
        PersistentStorage.shared().reset()
        let model = MasterModel(persistance: .ephemeral, weightTensor: GlobalsTests.WEIGHT_TENSOR)
        
        let groceries = TransactionCategory("groceries").getIntId()
        let gas = TransactionCategory("gas").getIntId()
        let online_shopping = TransactionCategory("online_shopping").getIntId()
        
        XCTAssertEqual(model!.categorise(transactionDescription: "Amazon", transactionAmount: -12, personal: .personal), online_shopping)
        XCTAssertEqual(model!.categorise(transactionDescription: "Amazon", transactionAmount: -70, personal: .personal), online_shopping)
        
        try! model!.learn(transactionDescription: "Amazon", transactionAmount: -12, personalCategoryId: groceries)
        try! model!.learn(transactionDescription: "Amazon", transactionAmount: -12, personalCategoryId: groceries)
        
        XCTAssertEqual(model!.categorise(transactionDescription: "Amazon", transactionAmount: -12, personal: .personal), groceries)
        XCTAssertEqual(model!.categorise(transactionDescription: "Amazon", transactionAmount: -70, personal: .personal), online_shopping)
        
//        XCTAssertEqual(model!.categorise(transactionDescription: "bp station", transactionAmount: -12, personal: .personal), gas)
//        XCTAssertEqual(model!.categorise(transactionDescription: "bp station", transactionAmount: -70, personal: .personal), gas)
//
//        try! model!.learn(transactionDescription: "bp station", transactionAmount: -12, personalCategoryId: groceries)
//
//        XCTAssertEqual(model!.categorise(transactionDescription: "bp station", transactionAmount: -12, personal: .personal), groceries)
//        XCTAssertEqual(model!.categorise(transactionDescription: "bp station", transactionAmount: -70, personal: .personal), gas)
    }
    
    func testLearnAndCategorize() {        
        PersistentStorage.shared().reset()
        let model = MasterModel(persistance: .ephemeral, weightTensor: GlobalsTests.WEIGHT_TENSOR)
                
        let children = TransactionCategory("children").getIntId()
        let traffic_fine = TransactionCategory("traffic_fine").getIntId()
        let alimony = TransactionCategory("alimony").getIntId()
        let groceries = TransactionCategory("groceries").getIntId()
        //let insurance = UInt8(TransactionCategory(id: "insurance", subId: "").getIntId())
        let gas = TransactionCategory("gas").getIntId()
        let fees_charges = TransactionCategory("fees_tax_charges").getIntId()
        let clothes = TransactionCategory("clothes").getIntId()
        let resto = TransactionCategory("restaurants").getIntId()
        
        do {
            try model!.learn(transactionDescription: "Stadt Bülach trx number 401", transactionAmount: -30, personalCategoryId: traffic_fine)
            try model!.learn(transactionDescription: "Stadt Bülach trx number 400", transactionAmount: -1600, personalCategoryId: children)
            try model!.learn(transactionDescription: "Binkys stupid money transfer again", transactionAmount: -1400, personalCategoryId: alimony)
            try model!.learn(transactionDescription: "bp station", transactionAmount: -12, personalCategoryId: groceries)
        } catch {
            print("*** \(error) *** ")
        }
        
        XCTAssertEqual(model!.categorise(transactionDescription: "Stadt Bülach trx number 400", transactionAmount: -1600, personal: .personal), children)
        XCTAssertEqual(model!.categorise(transactionDescription: "Stadt Bülach trx number 400", transactionAmount: -1600, personal: .nonPersonal), resto)
        
        XCTAssertEqual(model!.categorise(transactionDescription: "Stadt Bülach trx number 401", transactionAmount: -30, personal: .personal), traffic_fine)
        XCTAssertEqual(model!.categorise(transactionDescription: "Stadt Bülach trx number 401", transactionAmount: -30, personal: .nonPersonal), resto)
        
        XCTAssertEqual(model!.categorise(transactionDescription: "Binkys stupid money transfer again", transactionAmount: -1400, personal: .personal), alimony)
        XCTAssertEqual(model!.categorise(transactionDescription: "Binkys stupid money transfer again", transactionAmount: -1400, personal: .nonPersonal), clothes)
        
        XCTAssertEqual(model!.categorise(transactionDescription: "bp station", transactionAmount: -12, personal: .personal), groceries)
        XCTAssertEqual(model!.categorise(transactionDescription: "bp station", transactionAmount: -70, personal: .personal), gas)
        XCTAssertEqual(model!.categorise(transactionDescription: "bp station", transactionAmount: -70, personal: .nonPersonal), gas)
    }
}
