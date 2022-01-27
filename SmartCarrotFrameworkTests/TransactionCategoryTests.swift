//
//  ModelProtocol.swift
//  OutlabFramework
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import XCTest
@testable import SmartCarrotFramework

class TransactionCategoryTests: XCTestCase {

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

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testToString() {
        XCTAssertEqual(TransactionCategory().toString(), "not_categorized")
        XCTAssertEqual(TransactionCategory("mortgage_interest").toString(), "housing / mortgage_interest")
    }
    
    func testToStringShort() {
        XCTAssertEqual(TransactionCategory().toStringShort(), "not_categorized")
        XCTAssertEqual(TransactionCategory("mortgage_interest").toStringShort(), "mortgage_interest")
        XCTAssertEqual(TransactionCategory("housing").toStringShort(), "housing")
    }
    
    func testGetParentCategory() {
        let category = TransactionCategory("mortgage_interest")
        let parentCategory = category.getParentCategory()
        
        XCTAssertEqual(parentCategory!.idName, "housing")
        
        let parentParentCategory = parentCategory!.getParentCategory()
        XCTAssertNil(parentParentCategory)
    }
    
    func testOptionals() {
        let catId: String? = nil
        let catInId: Int? = nil
        
        var category = TransactionCategory(catId)
        
        XCTAssertEqual(category.idName, TransactionCategory.UNCATEGORISED_IDNAME)
        
        category = TransactionCategory(catInId)
        XCTAssertEqual(category.idName, TransactionCategory.UNCATEGORISED_IDNAME)
    }
    
    func testTopSubLevel() {
        XCTAssertTrue(TransactionCategory("cash").isParent())
        XCTAssertTrue(TransactionCategory().isParent())
        XCTAssertTrue(TransactionCategory("health").isParent())
        XCTAssertFalse(TransactionCategory("canton_tax").isParent())
        
        XCTAssertTrue(TransactionCategory("garden").isSub())
        XCTAssertTrue(TransactionCategory("building_insurance").isSub())
        XCTAssertFalse(TransactionCategory().isSub())
    }
    
    func testGetParentCategories() {
        let categories = TransactionCategory.getParentCategories()
        
        XCTAssertTrue(categories.count > 0)
    }
}
