//
//  ZenAPI.swift
//  SmartCarrotFramework
//
//  Copyright © 2020 CarrotLabs gmbh. All rights reserved.
//

import Foundation

/**
 `ZenAPI` class is responsible for building Zen Scores.

 The object of the class cannot be explicitly instantiated, please call `CarrotContext.getZenAPI()` for that.
 */
public final class ZenAPI : ModuleAPI {
    private let _transactionAPI: TransactionAPI
    private let _budgetAPI: BudgetAPI
    
    internal init(transactionAPI: TransactionAPI, budgetAPI: BudgetAPI, credentials: CarrotCredentials?) throws {
        _transactionAPI = transactionAPI
        _budgetAPI = budgetAPI
        
        super.init(modules: [LicenseDecoder.MODULE_ZEN], credentials: credentials)
        
        try validateSettings()
    }
    
    /**
     Builds an array of `ZenScore`s based on user's saved financial information.
     
     - Throws `CarrotContextError.zenScoreNoBudgets` if there is no one budget found.
     
     - Returns: An array with user's `ZenScore`. The array includes all the days from the first saved transaction date to the last saved transaction date consequently. The maximum interval is limited by three years, and if it is exceeded then the last date in the `ZenScore` sequence is the last saved transaction date.
     */
    public func buildZen() throws -> [ZenScore] {
        return try buildZen(transactions: _transactionAPI.getAll(), budgets: _budgetAPI.getAll())
    }
    
    /**
    Builds an array of `ZenScore`s based on user's saved financial information.
     
    - Parameter startDate: the first date for the generated `ZenScore` sequence.
    - Parameter endDate: the last date for the generated `ZenScore` sequence.
    
    - Throws `CarrotContextError.zenScoreNoBudgets` if there is no budgets in the persistent storage.
    
    - Returns: An array with user's `ZenScore`. The array includes all the days from the `startDate` to the `endDate` consequently. The maximum interval is limited by three years, and if it is exceeded then the last date in the `ZenScore` sequence is the `endDate` date.
    */
    public func buildZen(startDate: Date, endDate: Date) throws -> [ZenScore] {
        let transactions = try _transactionAPI.getAll().filter { $0.bookingDate >= startDate && $0.bookingDate <= endDate}
        return try buildZen(transactions: transactions, budgets: _budgetAPI.getAll())
    }
    
    internal func buildZen(transactions: [Transaction], budgets: [Budget]) throws -> [ZenScore] {
        if budgets.count == 0 {
            throw CarrotContextError.zenScoreNoBudgets
        }
        
        let zenBuilder = Zen(transactions: transactions, budgets: budgets)
        return zenBuilder.build()
    }
}
