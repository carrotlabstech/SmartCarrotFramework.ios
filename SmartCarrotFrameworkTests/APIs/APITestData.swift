//
//  APITestData.swift
//  SmartCarrotFrameworkTests
//
//  Copyright © 2020 CarrotLabs gmbh. All rights reserved.
//

import Foundation
@testable import SmartCarrotFramework

internal class APITestData {
    static let category1 = 100
    static let category2 = 18
    
    internal func getTransactions() -> (tx1: Transaction, tx2: Transaction, tx3: Transaction) {
        let txDate = Date(timeIntervalSinceNow: -3600*24*10)
        
        let tx1 = Transaction(id: UUID().uuidString,
            externalId: "111",
            amount: -100.34,
            currency: "CHF",
            sourceAmount: -90.12,
            sourceCurrency: "EUR",
            sourceExchangeRate: 1.12,
            bookingText: "this is a great booking text3",
            bookingDate: txDate,
            valueDate: txDate,
            categoryId: 45,
            userCategoryId: 0,
            accountId: "301",
            userNote: nil,
            customProperty1: "{ value: 100, name: \"ohoho\" }",
            customProperty2: "",
            created: Date(),
            modified: Date())
        let tx2 = Transaction(id: UUID().uuidString,
            externalId: "222",
            amount: -300.34,
            currency: "CHF",
            sourceAmount: nil,
            sourceCurrency: nil,
            sourceExchangeRate: nil,
            bookingText: "this is a great booking text1",
            bookingDate: txDate,
            valueDate: txDate,
            categoryId: 99,
            userCategoryId: 0,
            accountId: "301",
            userNote: nil,
            customProperty1: "{ value: 100, name: \"ohoho\" }",
            customProperty2: "",
            created: Date(),
            modified: Date())
        let tx3 = Transaction(id: UUID().uuidString,
            externalId: "333",
            amount: 20.34,
            currency: "CHF",
            sourceAmount: 2.12,
            sourceCurrency: "GBP",
            sourceExchangeRate: 10.12,
            bookingText: "this is a great booking text2",
            bookingDate: txDate,
            valueDate: txDate,
            categoryId: 22,
            userCategoryId: 0,
            accountId: "303",
            userNote: nil,
            customProperty1: "{ value: 100, name: \"ohoho\" }",
            customProperty2: "",
            created: Date(),
            modified: Date())

        return (tx1, tx2, tx3)
    }
    
    internal func getTransactionsForBudgeting() throws -> [Transaction] {
        var result = [Transaction]()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        var tx1 = Transaction(id: UUID().uuidString,
            amount: -100,
            currency: "CHF",
            bookingText: "this is a great booking text",
            bookingDate: formatter.date(from: "2020/02/05")!,
            categoryId: APITestData.category1)
        result.append(tx1)
        
        tx1 = Transaction(id: UUID().uuidString,
            amount: -300,
            currency: "CHF",
            bookingText: "this is a great booking text",
            bookingDate: formatter.date(from: "2020/02/07")!,
            categoryId: APITestData.category1)
        result.append(tx1)
        
        tx1 = Transaction(id: UUID().uuidString,
            amount: -150,
            currency: "CHF",
            bookingText: "this is a great booking text",
            bookingDate: formatter.date(from: "2020/02/14")!,
            categoryId: APITestData.category1)
        result.append(tx1)
        
        // different category
        tx1 = Transaction(id: UUID().uuidString,
            amount: -333,
            currency: "CHF",
            bookingText: "this is a great booking text",
            bookingDate: formatter.date(from: "2020/02/05")!,
            categoryId: APITestData.category2)
        result.append(tx1)
        
        // different months of the same year
        tx1 = Transaction(id: UUID().uuidString,
            amount: -1000,
            currency: "CHF",
            bookingText: "this is a great booking text",
            bookingDate: formatter.date(from: "2020/01/05")!,
            categoryId: APITestData.category1)
        result.append(tx1)
        
        // different year
        tx1 = Transaction(id: UUID().uuidString,
            amount: -7,
            currency: "CHF",
            bookingText: "this is a great booking text",
            bookingDate: formatter.date(from: "2019/05/05")!,
            categoryId: APITestData.category1)
        result.append(tx1)
        
        return result
    }
    
    internal func getTransactionsForBudgetingEvents() throws -> [Transaction] {
        var result = [Transaction]()
        
        // Date() - always belongs to the current month, what is important
        
        var tx1 = Transaction(id: UUID().uuidString,
            amount: -100,
            currency: "CHF",
            bookingText: "this is a great booking text",
            bookingDate: Date(),
            categoryId: APITestData.category1)
        result.append(tx1)
        
        tx1 = Transaction(id: UUID().uuidString,
            amount: -300,
            currency: "CHF",
            bookingText: "this is a great booking text",
            bookingDate: Date(),
            categoryId: APITestData.category1)
        result.append(tx1)
        
        tx1 = Transaction(id: UUID().uuidString,
            amount: -150,
            currency: "CHF",
            bookingText: "this is a great booking text",
            bookingDate: Date(),
            categoryId: APITestData.category1)
        result.append(tx1)
        
        // different category
        tx1 = Transaction(id: UUID().uuidString,
            amount: -333,
            currency: "CHF",
            bookingText: "this is a great booking text",
            bookingDate: Date(),
            categoryId: APITestData.category2)
        result.append(tx1)
        
        // different months of the same year
        tx1 = Transaction(id: UUID().uuidString,
            amount: -1000,
            currency: "CHF",
            bookingText: "this is a great booking text",
            bookingDate: Date(),
            categoryId: APITestData.category2)
        result.append(tx1)
        
        // different year
        tx1 = Transaction(id: UUID().uuidString,
            amount: -7,
            currency: "CHF",
            bookingText: "this is a great booking text",
            bookingDate: Date(),
            categoryId: APITestData.category2)
        result.append(tx1)
        
        return result
    }
    
    internal func getBudgets() -> (b1:Budget, b2:Budget, b3:Budget) {
        let b1 = Budget(id: UUID().uuidString,
                         externalId: "201",
                         name: "sweets",
                         budgeted: 1000,
                         alert: 430,
                         categoryId: APITestData.category1,
                         frequencyType: BudgetFrequency.monthly)
        let b2 = Budget(id: UUID().uuidString,
                        externalId: "202",
                        name: "houses",
                        budgeted: 1000,
                        alert: 800,
                        categoryId: APITestData.category2,
                        frequencyType: .annual)
        let b3 = Budget(id: UUID().uuidString,
                        externalId: "203",
                        name: "restaurants",
                        budgeted: 300,
                        alert: 200,
                        categoryId: APITestData.category1,
                        frequencyType: .annual)
        
        return (b1, b2, b3)
    }
    
    internal func getTransactionsForBudgetRunningTotal() -> [Transaction] {
        var result = [Transaction]()
        
        // Date() - always belongs to the current month, what is important
        
        // parent category
        var tx1 = Transaction(id: UUID().uuidString,
            amount: -111,
            currency: "CHF",
            bookingText: "this is a great booking text",
            bookingDate: Date(),
            categoryId: TransactionCategory.init("leisure_shopping").getIntId())
        result.append(tx1)
        
        // sub category - should not be accounted
        tx1 = Transaction(id: UUID().uuidString,
            amount: -200,
            currency: "CHF",
            bookingText: "this is a great booking text",
            bookingDate: Date(),
            categoryId: TransactionCategory.init("electronics").getIntId())
        result.append(tx1)
        
        // uncategorised
        tx1 = Transaction(id: UUID().uuidString,
            amount: -350,
            currency: "CHF",
            bookingText: "this is a great booking text",
            bookingDate: Date(),
            categoryId: TransactionCategory.UNCATEGORISED_INT_ID)
        result.append(tx1)
        
        // just a different one to bring in some randomness
        tx1 = Transaction(id: UUID().uuidString,
            amount: -333,
            currency: "CHF",
            bookingText: "this is a great booking text",
            bookingDate: Date(),
            categoryId: TransactionCategory.init("cash").getIntId())
        result.append(tx1)
        
        return result
    }
    
    internal func getBudgetsForRunningTotal() -> (b_leisure_shopping:Budget, b_electronics:Budget, b_default:Budget) {
        let b_leisure_shopping = Budget(id: UUID().uuidString,
                         externalId: "201",
                         name: "sweets",
                         budgeted: 1000,
                         alert: 430,
                         categoryId: TransactionCategory.init("leisure_shopping").getIntId(),
                         frequencyType: .monthly)
        let b_electronics = Budget(id: UUID().uuidString,
                        externalId: "202",
                        name: "houses",
                        budgeted: 1000,
                        alert: 800,
                        categoryId: TransactionCategory.init("electronics").getIntId(),
                        frequencyType: .monthly)
        let b_default = Budget(id: UUID().uuidString,
                        externalId: "203",
                        name: "restaurants",
                        budgeted: 300,
                        alert: 200,
                        categoryId: TransactionCategory.UNCATEGORISED_INT_ID,
                        frequencyType: .monthly)
        
        return (b_leisure_shopping, b_electronics, b_default)
    }

}
