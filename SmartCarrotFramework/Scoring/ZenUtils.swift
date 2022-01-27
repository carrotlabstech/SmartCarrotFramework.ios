//
//  ZenUtils.swift
//  SmartCarrotFramework
//
//  Copyright © 2020 CarrotLabs gmbh. All rights reserved.
//

import Foundation

internal class ZenUtils {
    internal static func r(x: Decimal, alpha: Decimal, beta: Decimal, gamma: Decimal) -> Decimal {
        return Decimal( Double(1) / (pow(abs(1-alpha * x).doubleValue, gamma.doubleValue))  - exp(beta.doubleValue * (x.doubleValue-1)) - Double(1) + exp(-beta.doubleValue))
    }
    
    internal static func sigmoid(x: Decimal) -> Decimal {
        return Decimal(1 / (1 + exp( -x.doubleValue)))
    }
    
    internal static func budgetsIncludeCategory(budgets: [Budget], categoryId: Int?) -> Bool {
        guard let txCategoryId = categoryId else {
            return false
        }
        
        return budgets.firstIndex { $0.categoryId == txCategoryId } != nil
    }
    
    internal static func daySince1970(date: Date) -> Int {
        let calendar = Calendar.current

        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: Date(timeIntervalSince1970: 0))
        let date2 = calendar.startOfDay(for: date)

        return calendar.dateComponents([.day], from: date1, to: date2).day! + 1
    }
    
    internal static func daysPerMonth(monthSince1970: Int) -> Int {
        let m1970 = getYearMonthFromMonth1970(monthSince1970: monthSince1970)
        
        let dateComponents = DateComponents(year: m1970.year, month: m1970.month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!

        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    internal static func getYearMonthFromMonth1970(monthSince1970: Int) -> (year: Int, month: Int) {
        var year = monthSince1970 / 12
        var month = monthSince1970 % 12
        
        if month == 0 {
            year = year - 1
            month = 12
        }
        
        return (year + 1970, month)
    }
    
    internal static func monthSince1970(daySince1970: Int) -> Int {
        let date = Date(timeIntervalSince1970: Double((daySince1970 - 1) * 3600 * 24))
        
        let calendar = Calendar.current

        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: Date(timeIntervalSince1970: 0))
        let date2 = calendar.startOfDay(for: date)

        return calendar.dateComponents([.month], from: date1, to: date2).month! + 1
    }
    
    internal static func dayOfMonth(daySince1970: Int) -> Int {
        let date = Date(timeIntervalSince1970: Double((daySince1970 - 1) * 3600 * 24))
        
        let calendar = Calendar.current
        return calendar.component(.day, from: date)
    }
    
    internal static func date(daySince1970: Int) -> Date {
        return Date(timeIntervalSince1970: Double((daySince1970 - 1) * 3600 * 24))
    }
}
