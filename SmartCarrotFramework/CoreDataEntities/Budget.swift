//
//  Budget.swift
//  SmartCarrotFramework
//
//  Copyright © 2020 CarrotLabs gmbh. All rights reserved.
//

import Foundation

/**
 Budget Frequency
 */
public enum BudgetFrequency : Int {
    /**
     Montly, starts from the first day of a month
     */
    case monthly = 1
    
    /**
     Annual, starts from the first day of a year
     */
    case annual = 2
}

/**
 Incremental Budget
 */
public struct Budget : EntityWithId {
    /**
     Budget Id, maintained by the customer
     */
    public var id: String
    /**
     External Id
     */
    public var externalId: String?
    /**
     Account Id. Is not taken into account for calculations, reserved for future use.
     */
    public var accountId: String?
    
    /**
     Currency. Is not taken into account for calculations, reserved for future use.
     */
    public var currency: String?
    /**
     Budget Name
     */
    public var name: String
    
    private var _budgeted: Decimal
    /**
     Budgeted Amount, always positive
     */
    public var budgeted: Decimal {
        get {
            return _budgeted
        }
        set (newBudgeted) {
            _budgeted = newBudgeted < 0 ? 0 : newBudgeted
        }
    }

    private var _alert: Decimal
    /**
     Budget Alert Threshold, a notification will be sent if it has been reached
     */
    public var alert: Decimal {
        get {
            return _alert
        }
        set (newAlert) {
            _alert = newAlert < 0 ? 0 : newAlert
        }
    }

    private var _categoryId: Int
    /**
     Budget Category Id
     */
    public var categoryId: Int {
        get {
            return _categoryId
        }
        set (newCategoryId) {
            _categoryId = newCategoryId < 0 ? 0 : newCategoryId
        }
    }
    
    /**
     Budget Frequency Type
     */
    public var frequencyType: BudgetFrequency
    
    // Forced to implement this constructor because of Swift, who treats non-explicitely implemented struct constructors as *internal*
    /**
     Initialises a new incremental budget.
     
     - Parameter id: id of the new budget
     - Parameter externalId: external id of the new budget, can be nil
     - Parameter currency: budget currency. Is not taken inoto account for calculations, reserved for future use.
     - Parameter accountId: accountId id of the new budget, can be nil. Reserved for future use.
     - Parameter name: name of the new budget
     - Parameter budgeted: the budgeted amount, can't be negative. Will be set to zero if a negative amount passed
     - Parameter alert: the alert threshold level amount, can't be negative. Will be set to zero if a negative amount passed
     - Parameter categoryId: the budget category, can't be negative. Will be set to `TransactionCategory.UNCATEGORISED_IDNAME` if a negative amount passed
     - Parameter frequencyType: the budget frequency (e.g. monthly / annual)
     */
    public init(id: String = "",
                externalId: String? = nil,
                currency: String? = nil,
                accountId: String? = nil,
                name: String = "",
                budgeted: Decimal = 0,
                alert: Decimal = 0,
                categoryId: Int = TransactionCategory.UNCATEGORISED_INT_ID,
                frequencyType: BudgetFrequency = .monthly) {
        self.id = id.trimmingCharacters(in: .whitespacesAndNewlines)
        self.externalId = externalId
        self.accountId = accountId
        self.name = name
        self._budgeted = budgeted < 0 ? 0 : budgeted
        self._alert = alert < 0 ? 0 : alert
        self._categoryId = categoryId <= 0 ? TransactionCategory.UNCATEGORISED_INT_ID : categoryId
        self.frequencyType = frequencyType
    }
    
    /**
     An empty constructor.
     Sets Budget id to the empty string and category to `UNCATEGORISED` category.
     */
    public init() {
        self.id = ""
        self.name = ""
        self.currency = nil
        self._budgeted = 0
        self._alert = 0
        self._categoryId = TransactionCategory.UNCATEGORISED_INT_ID
        self.frequencyType = .monthly
    }
}
