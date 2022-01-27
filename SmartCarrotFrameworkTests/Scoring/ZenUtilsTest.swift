//
//  ZenUtilsTest.swift
//  SmartCarrotFrameworkTests
//
//  Copyright © 2020 CarrotLabs gmbh. All rights reserved.
//

import XCTest
@testable import SmartCarrotFramework

class ZenUtilsTest: XCTestCase {
    func testNumberOfDays() {
        XCTAssertEqual(31, ZenUtils.daysPerMonth(monthSince1970: 1))
        XCTAssertEqual(31, ZenUtils.daysPerMonth(monthSince1970: 13))
        XCTAssertEqual(28, ZenUtils.daysPerMonth(monthSince1970: 14))
        XCTAssertEqual(29, ZenUtils.daysPerMonth(monthSince1970: 26))
        
        XCTAssertEqual(30, ZenUtils.daysPerMonth(monthSince1970: 585))
        XCTAssertEqual(31, ZenUtils.daysPerMonth(monthSince1970: 586))
        XCTAssertEqual(30, ZenUtils.daysPerMonth(monthSince1970: 587))
        XCTAssertEqual(31, ZenUtils.daysPerMonth(monthSince1970: 588))
        XCTAssertEqual(31, ZenUtils.daysPerMonth(monthSince1970: 589))
        XCTAssertEqual(28, ZenUtils.daysPerMonth(monthSince1970: 590))
    }
    
    func testGetDayNoSince1970() {
        XCTAssertEqual(2, ZenUtils.daySince1970(date: Date(timeIntervalSince1970: 1 * 24 * 3600 + 16 * 3600)))
        
        let year: Double = 1 * 365 * 24 * 3600
        let january: Double = 31 * 24 * 3600
        let hours: Double = 16 * 3600
        let timeInterval: Double = year + january + hours
        
        let daysNumber = 365 + 31 + 1
        XCTAssertEqual(daysNumber, ZenUtils.daySince1970(date: Date(timeIntervalSince1970: timeInterval)))
        
        XCTAssertEqual(14, ZenUtils.monthSince1970(daySince1970: daysNumber))
    }
    
    func testGetMonthSince1970() {
        XCTAssertEqual(1, ZenUtils.monthSince1970(daySince1970: 5))
        XCTAssertEqual(4, ZenUtils.monthSince1970(daySince1970: 105))
        XCTAssertEqual(13, ZenUtils.monthSince1970(daySince1970: 370))
        XCTAssertEqual(585, ZenUtils.monthSince1970(daySince1970: 17805))
    }
    
    func testYearMonthSince1970() {
        var pair = ZenUtils.getYearMonthFromMonth1970(monthSince1970: 13)
        XCTAssertEqual(1971, pair.year)
        XCTAssertEqual(1, pair.month)
        
        pair = ZenUtils.getYearMonthFromMonth1970(monthSince1970: 11)
        XCTAssertEqual(1970, pair.year)
        XCTAssertEqual(11, pair.month)
        
        pair = ZenUtils.getYearMonthFromMonth1970(monthSince1970: 12)
        XCTAssertEqual(1970, pair.year)
        XCTAssertEqual(12, pair.month)
        
        pair = ZenUtils.getYearMonthFromMonth1970(monthSince1970: 24)
        XCTAssertEqual(1971, pair.year)
        XCTAssertEqual(12, pair.month)
        
        
        let monthSince1970 = ZenUtils.monthSince1970(daySince1970: 17885)
        XCTAssertEqual(588, monthSince1970)

        pair = ZenUtils.getYearMonthFromMonth1970(monthSince1970: monthSince1970)
        XCTAssertEqual(2018, pair.year)
        XCTAssertEqual(12, pair.month)
        
        print(ZenUtils.getYearMonthFromMonth1970(monthSince1970: ZenUtils.monthSince1970(daySince1970: 17801)))
        print(ZenUtils.dayOfMonth(daySince1970: 17801))
    }
    
    func testDayOfMonth() {
        XCTAssertEqual(1, ZenUtils.dayOfMonth(daySince1970: 1))
        XCTAssertEqual(5, ZenUtils.dayOfMonth(daySince1970: 36))
        XCTAssertEqual(25, ZenUtils.dayOfMonth(daySince1970: 17800))
    }
    
    func testGetDate() {
        let calendar = Calendar.current
        
        var date = ZenUtils.date(daySince1970: 1)
        var year = calendar.component(.year, from: date)
        var month = calendar.component(.month, from: date)
        var day = calendar.component(.day, from: date)
        XCTAssertTrue(year == 1970 && month == 1 && day == 1)
        
        
        date = ZenUtils.date(daySince1970: 365 + 31 + 5)
        year = calendar.component(.year, from: date)
        month = calendar.component(.month, from: date)
        day = calendar.component(.day, from: date)
        XCTAssertTrue(year == 1971 && month == 2 && day == 5)
        
        date = ZenUtils.date(daySince1970: 17803)
        year = calendar.component(.year, from: date)
        month = calendar.component(.month, from: date)
        day = calendar.component(.day, from: date)
        XCTAssertTrue(year == 2018 && month == 9 && day == 28)
        
    }
}
