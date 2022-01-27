//
//  BudgetAPI.swift
//  SmartCarrotFramework
//
//  Copyright © 2020 CarrotLabs gmbh. All rights reserved.
//

import Foundation

/**
 The `BudgetAPI` class provides access to various incremental budget related functionality.
 
 The object of the class cannot be explicitly instantiated, please call `CarrotContext.getBudgetAPI()` for that.
 */
public final class BudgetAPI : ModuleAPI {
    private let _repository = BudgetRepository()
    private var _budgetContainers = [BudgetContainer]()
    private let _transactionAPI: TransactionAPI
    
    internal init(transactionAPI: TransactionAPI, credentials: CarrotCredentials?) throws {
        _transactionAPI = transactionAPI
        
        super.init(modules: [LicenseDecoder.MODULE_BUDGETS], credentials: credentials)
        
        try validateSettings()
        
        try buildBudgetContainers()

        // No need to remove these obersevers at deinit,
        // If your app targets iOS 9.0 and later or macOS 10.11 and later, you don't need to unregister an observer in its dealloc method.
        NotificationCenter.default.addObserver(forName: .transactionListDidUpdate, object: nil, queue: nil, using: self.transactionListDidUpdateHandler)
        NotificationCenter.default.addObserver(forName: .budgetListDidUpdate, object: nil, queue: nil, using: self.budgetListDidUpdateHandler)
    }
    
    // MARK: - CRUD
    /**
     Updates or inserts an array of budgets in the persistent storage. Identifies budgets by their `id`.
     
     - Parameter budgets: an array of `Budget` to add or update.
     
     - Throws
     */
    public func upsert(budgets: [Budget]) throws {
        try validateSettings()
        try _repository.addUpdate(items: budgets)
    }
    
    /**
     Deletes an array of budgets from the persistent storage. Identifies budgets by their `id`.
     
     - Parameter budgets: an array of `Budget` to be deleted.
     */
    public func delete(budgets: [Budget]) throws {
        try validateSettings()
        return try _repository.delete(items: budgets)
    }
    
    /// Finds all budgets from the persistent storage.
    public func getAll() throws -> [Budget] {
        try validateSettings()
        return try _repository.getAll()
    }
    
    /** Finds all budgets from the persistent storage, sorted.
     
     Ordered by (in order of priority):
     - `name` asc,
     - `id` asc.
    */
    public func getAllOrderByNameId() throws -> [Budget] {
        return try getAll().sorted {
            if $0.name != $1.name {
                return $0.name < $1.name
            } else {
                return $0.id < $1.id
            }
        }
    }
    
    /**
     Finds a `Budget` by its `id`, `nil` if the `Budget` was not found.
     
     - Parameter id: a `Budget` id.
     */
    public func getById(id: String) throws -> Budget? {
        try validateSettings()
        return try _repository.getById(id: id)
    }
    
    // Running Totals, Alerts, and Transaction Count: - CRUD
    /**
     Finds a count of transactions, which match the `Budget` by:
     - `current` month if the `budget` is `.monthly`
     - `current` month and year if the budget is `.annually`
     - category
     - currency (currently not implemented, reserved for future use)
     - accountId (currently not implemented, reserved for future use)
     
     # Note:
     If a budget matches a category, then category's sub-categories doesn't match the budget.
     
     - Parameter budget: a `Budget` to find the matching transactions count for.
     
     - Returns: count of transactions
     */
    public func getTransactionsCount(budget: Budget) throws -> Int {
        let calendar = Calendar.current
        let today = Date()
        let year = calendar.component(.year, from: today)
        let month = calendar.component(.month, from: today)
        
        return try getTransactionsCount(budget: budget, year: year, month: month)
    }

    /**
     Finds a count of transactions, which match the `Budget` by:
     - `month` if the `budget` is `.monthly`
     - `month` and `year` if the budget is `.annually`
     - category
     - currency (currently not implemenetd, reserved for future use)
     - accountId (currently not implemenetd, reserved for future use)
     
     # Note:
     If a budget matches a category, then category's sub-categories doesn't match the budget.
     
     - Parameter budget: a `Budget` to find the matching transactions count for.
     - Parameter year: a year to find the matching transactions count for.
     - Parameter month: a month to find the matching transactions count for.
     
     - Returns: count of transactions
     */
    public func getTransactionsCount(budget: Budget, year: Int, month: Int) throws -> Int {
        var total:Int = 0
        
        for transaction in try _transactionAPI.getAll() {
            if TransactionBelongsToBudget(transaction: transaction, budget: budget, year: year, month: month) {
                total += 1
            }
        }
        
        return total
    }

    /**
     Calculates budget running total as per `today`.
     
     - Parameter budget: a `Budget` to find the running total for.
     
     - Returns: budget running total.
     
     # Note:
     Running total is always positive, it's an absolute value of all the transaction values.
     */
    public func getRunningTotal(budget: Budget) throws -> Decimal {
        let calendar = Calendar.current
        let today = Date()
        let year = calendar.component(.year, from: today)
        let month = calendar.component(.month, from: today)

        return try getRunningTotal(budget: budget, year: year, month: month)
    }

    /**
     Calculates budget running total as per selected year and month.
     
     - Parameter budget: a `Budget` to find the running total for.
     - Parameter year: chosen year to calculate the running total for.
     - Parameter month: chosen month to calculate the running total for.
     
     - Returns: budget running total.
     
     # Note:
     Running total is always positive, it's an absolute value of all the transaction values.
     */
    public func getRunningTotal(budget: Budget, year: Int, month: Int) throws -> Decimal {
        var total:Decimal = 0
        
        for transaction in try _transactionAPI.getAll() {
            if TransactionBelongsToBudget(transaction: transaction, budget: budget, year: year, month: month) {
                total += transaction.amount
            }
        }
        
        return abs(total)
    }
    
    /**
     Calculates budget balance as per `today`.
     
     - Parameter budget: a `Budget` to find the balance.
     
     - Returns: budget balance.
     */
    public func getBalance(budget: Budget) throws -> Decimal {
        return try budget.budgeted - getRunningTotal(budget: budget)
    }

    /**
     Calculates budget balance as per selected year and month.
     
     - Parameter budget: a `Budget` to find the balance for.
     - Parameter year: chosen year to calculate the balance for.
     - Parameter month: chosen month to calculate the balance for.
     
     - Returns: budget balance.
     */
    public func getBalance(budget: Budget, year: Int, month: Int) throws -> Decimal {
        return try budget.budgeted - getRunningTotal(budget: budget, year: year, month: month)
    }
    
    internal override func validateSettings() throws {
        try super.validateSettings()
        
        if SharedContext.shared.key.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
            throw CarrotContextError.encryptionKeyNotSetError
        }
        
        if SharedContext.shared.iv.trimmingCharacters(in: .whitespacesAndNewlines).count != 16 {
            throw CarrotContextError.encryptionInvalidInitialisationVectorError
        }
    }
    
    private func TransactionBelongsToBudget(transaction: Transaction, budget: Budget, year: Int, month: Int) -> Bool {
        let txCategoryId = transaction.categoryId == nil ? TransactionCategory.UNCATEGORISED_INT_ID : transaction.categoryId
        
        let calendar = Calendar.current
        let txYear = calendar.component(.year, from: transaction.bookingDate)
        let txMonth = calendar.component(.month, from: transaction.bookingDate)
        
        return txCategoryId == budget.categoryId && (txYear == year && (txMonth == month || budget.frequencyType == .annual))
    }


    // budgets didn't change, only transactions
    // in this case is enough to recalc them and fire events
    private func transactionListDidUpdateHandler(notification: Notification) -> Void {
        for budgetContainer in _budgetContainers {
            do {
                let runningTotal = try getRunningTotal(budget: budgetContainer.budget)
                budgetContainer.validateAndPostBudgetOverspent(newRunningTotal: runningTotal)
            } catch {
                // do nothing, we just don't recalc and send notificaitons
            }
        }
    }

    // budgets changed
    private func budgetListDidUpdateHandler(notification: Notification) -> Void {
        do {
            try buildBudgetContainers()
        } catch {
            // do nothing, we just don't recalc and send notificaitons
        }
    }
    
    private func buildBudgetContainers() throws {
        let budgets = try _repository.getAll()
        
        _budgetContainers = [BudgetContainer]()
        for budget in budgets {
            _budgetContainers.append(BudgetContainer(budget: budget, runningTotal: try getRunningTotal(budget: budget)))
        }
    }
}
