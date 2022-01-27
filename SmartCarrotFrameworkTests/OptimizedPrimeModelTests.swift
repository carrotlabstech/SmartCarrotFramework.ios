//
//  CategoryOptimizedPrimeModelTests.swift
//  OutlabFrameworkTests
//
//  Copyright © 2019 Outlab gmbh. All rights reserved.
//

import XCTest
@testable import SmartCarrotFramework

class OptimizedPrimeModelTests: XCTestCase {
    let model = OptimizedPrimeModel(weightTensor: GlobalsTests.WEIGHT_TENSOR)
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

#if COUNTRY_US
    func testRunModelUSIndividual() {
        XCTAssertEqual(model?.categorise(transactionDescription: "Google", transactionAmount: -100, personal: .nonPersonal), 61) // gas
    }
    
    func testRunModelUS() {
        XCTAssertEqual(model?.categorise(transactionDescription: "gas", transactionAmount: -100, personal: .nonPersonal), 80) // gas
        XCTAssertEqual(model?.categorise(transactionDescription: "plane", transactionAmount: -100, personal: .nonPersonal), 91) // gas
        XCTAssertEqual(model?.categorise(transactionDescription: "donald", transactionAmount: -100, personal: .nonPersonal), 55) // gas
        XCTAssertEqual(model?.categorise(transactionDescription: "donalds", transactionAmount: -100, personal: .nonPersonal), 55) // gas
        XCTAssertEqual(model?.categorise(transactionDescription: "amazon", transactionAmount: -100, personal: .nonPersonal), 61) // gas
        XCTAssertEqual(model?.categorise(transactionDescription: "mobile", transactionAmount: -100, personal: .nonPersonal), 27) // gas
        XCTAssertEqual(model?.categorise(transactionDescription: "air", transactionAmount: -100, personal: .nonPersonal), 91) // gas
        
        XCTAssertEqual(model?.categorise(transactionDescription: "amazon.com", transactionAmount: -100, personal: .nonPersonal), 61) // gas
        XCTAssertEqual(model?.categorise(transactionDescription: "mcdonalds", transactionAmount: -100, personal: .nonPersonal), 55) // gas
        XCTAssertEqual(model?.categorise(transactionDescription: "WHATABURGER", transactionAmount: -100, personal: .nonPersonal), 62) // gas
        XCTAssertEqual(model?.categorise(transactionDescription: "STARBUCKS", transactionAmount: -100, personal: .nonPersonal), 55) // gas
        XCTAssertEqual(model?.categorise(transactionDescription: "WAL-MART", transactionAmount: -100, personal: .nonPersonal), 80) // gas
        XCTAssertEqual(model?.categorise(transactionDescription: "AMAZON MKTPLACE PMTS", transactionAmount: -100, personal: .nonPersonal), 61) // gas
        XCTAssertEqual(model?.categorise(transactionDescription: "AMAZON Inc.", transactionAmount: -100, personal: .nonPersonal), 61) // gas
        XCTAssertEqual(model?.categorise(transactionDescription: "Microsoft Inc.", transactionAmount: -100, personal: .nonPersonal), 61) // gas
        XCTAssertEqual(model?.categorise(transactionDescription: "AMAZON Inc.", transactionAmount: -100, personal: .nonPersonal), 61) // gas
        XCTAssertEqual(model?.categorise(transactionDescription: "AMAZON", transactionAmount: -100, personal: .nonPersonal), 61) // gas
        XCTAssertEqual(model?.categorise(transactionDescription: "Google Inc.", transactionAmount: -100, personal: .nonPersonal), 61) // gas
        XCTAssertEqual(model?.categorise(transactionDescription: "Google", transactionAmount: -100, personal: .nonPersonal), 61) // gas
        
        XCTAssertEqual(model?.categorise(transactionDescription: "HOTEL", transactionAmount: -100, personal: .nonPersonal), 93) // gas
        
        XCTAssertEqual(model?.categorise(transactionDescription: "account transfer", transactionAmount: -100, personal: .nonPersonal), 108) // gas
        XCTAssertEqual(model?.categorise(transactionDescription: "transfer", transactionAmount: -100, personal: .nonPersonal), 108) // gas
        XCTAssertEqual(model?.categorise(transactionDescription: "account transfer", transactionAmount: 100, personal: .nonPersonal), 108) // gas
    }
    
#elseif COUNTRY_CH
    
    func testRunModelCH() {
        XCTAssertEqual(model?.categorise(transactionDescription: "coop tankstelle", transactionAmount: -100, personal: .nonPersonal), 80) // gas
        XCTAssertEqual(model?.categorise(transactionDescription: "coop Paradeplatz", transactionAmount: -100, personal: .nonPersonal), 24) // groceries
        
        XCTAssertEqual(model?.categorise(transactionDescription: "apple", transactionAmount: -100, personal: .nonPersonal), 54) // parent category - shopping
        XCTAssertEqual(model?.categorise(transactionDescription: "apple digite", transactionAmount: -100, personal: .nonPersonal), 54) // electronics
        XCTAssertEqual(model?.categorise(transactionDescription: "INNERT 30 TAGEN, Z RICH LEBENSVERSICH.-, GESELLSCHAFT AG, POLICE: VXXL1X15701FSC900200(&*)60FS, CD, LSV Belastung CHF", transactionAmount: -100, personal: .nonPersonal), 49) // life_insurance
        XCTAssertEqual(model?.categorise(transactionDescription: "galaxu", transactionAmount: -100, personal: .nonPersonal), 61) // oneline shoppping
        XCTAssertEqual(model?.categorise(transactionDescription: "galaxu digitec", transactionAmount: -100, personal: .nonPersonal), 54) // electronics
        XCTAssertEqual(model?.categorise(transactionDescription: "galaxus digitec", transactionAmount: -100, personal: .nonPersonal), 54) // electronics
        XCTAssertEqual(model?.categorise(transactionDescription: "KAUF/DIENSTLEISTUNG VOM 21.05.2019 KARTEN NR. XXXX6610 Migros M Uitikon-Waldegg Uitikon Waldegg", transactionAmount: -100, personal: .nonPersonal), 24) // groceries
        XCTAssertEqual(model?.categorise(transactionDescription: "ATM Withdrawal", transactionAmount: -300, personal: .nonPersonal), 94)
        XCTAssertEqual(model?.categorise(transactionDescription: "Cash Withdrawal Using PIN UBS ZUERICH-FLUGHAFEN CARD 1234 1234, USD 1234.1234 RATE 1234", transactionAmount: -100, personal: .nonPersonal),  94)
        XCTAssertEqual(model?.categorise(transactionDescription: "Swiss Int Airlines", transactionAmount: -370, personal: .nonPersonal),  91)
        XCTAssertEqual(model?.categorise(transactionDescription: "Cash Withdrawal CARD 1234 1234 RB KAISERSTUHL, ON 1234.1234:1234 ID: 1234, AMOUNT EUR 1234, CHARGES (1234%,MIN.EUR 1234) EUR 1234, TOTAL DEBIT EUR 1234, RATE EUR/CHF 1234 (1234.1234)", transactionAmount: -100, personal: .nonPersonal),  94)
        
        XCTAssertEqual(model?.categorise(transactionDescription: "e-banking Order CHROMECAST DIGITEC AG, 1234 ZUERICH, E-Banking CHF domestic", transactionAmount: -50, personal: .nonPersonal), 54)
    }
    
    func testIndividualValues() {
        XCTAssertEqual(model?.categorise(transactionDescription: "coop tankstelle", transactionAmount: -100, personal: .nonPersonal), 80) // gas
    }
#endif
    
    
    func testIncome() {
        XCTAssertEqual(model?.categorise(transactionDescription: "Salary payment", transactionAmount: 15000, personal: .nonPersonal), 43) // income / wage
    }
    
    
}
