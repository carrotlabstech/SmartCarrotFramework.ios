//
//  Transaction.swift
//  SmartCarrotFramework
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import Foundation

/**
 Transaction
 */
public struct Transaction : EntityWithId {
    /**
     Transaction Id. Should be set and controlled by the customer.
    */
    public var id: String
    /**
     External Id
     */
    public var externalId: String?

    /**
     Amount. Used by budgets and budget alerts
     */
    public var amount: Decimal
    /**
     Currency
     */
    public var currency: String

    /**
     Source Amount
     */
    public var sourceAmount: Decimal?
    /**
     Source Currency
     */
    public var sourceCurrency: String?
    /**
     Source Exchange Rate
     */
    public var sourceExchangeRate: Decimal?

    /**
     Booking Text
     */
    public var bookingText: String
    /**
     Booking Date. Used by budgets and budget alerts, Zen scores
     */
    public var bookingDate: Date
    /**
     Value date
     */
    public var valueDate: Date?

    /**
     Category Id
     */
    public var categoryId: Int?
    /**
     User category Id
     */
    public var userCategoryId: Int?
    
    /**
     Transaction Account id
     */
    public var accountId: String?
    
    /**
     User notes
     */
    public var userNote: String?
    
    /// Customer property one, reserved for customer's use.
    public var customProperty1: String?
    /// Customer property two, reserved for customer's use.
    public var customProperty2: String?
    
    /// Transactions creation date
    public var created: Date?
    
    /// Transaction modification date
    public var modified: Date?
    
    /// Empty constructor. Transaction Id is initialised with an empty string, transaction currency is set to "CHF"
    public init() {
        self.id = ""
        self.bookingText = ""
        self.bookingDate = Date()
        self.amount = 0
        self.currency = "CHF"
    }
    
    public init(id: String = "",
                externalId: String? = nil,
                amount: Decimal = 0,
                currency: String = "CHF",
                sourceAmount: Decimal? = nil,
                sourceCurrency: String? = nil,
                sourceExchangeRate: Decimal? = nil,
                bookingText: String = "",
                bookingDate: Date = Date(),
                valueDate: Date? = nil,
                categoryId: Int? = nil,
                userCategoryId: Int? = nil,
                accountId: String? = nil,
                userNote: String? = nil,
                customProperty1: String? = nil,
                customProperty2: String? = nil,
                created: Date? = Date(),
                modified: Date? = Date()) {
        self.id = id
        self.bookingText = bookingText
        self.bookingDate = bookingDate
        self.amount = amount
        self.categoryId = categoryId
        self.currency = currency
    
        self.externalId = externalId
        self.sourceAmount = sourceAmount
        self.sourceCurrency = sourceCurrency
        self.sourceExchangeRate = sourceExchangeRate

        self.valueDate = valueDate
        self.userCategoryId = userCategoryId
        self.accountId = accountId
        self.userNote = userNote
        
        self.customProperty1 = customProperty1
        self.customProperty2 = customProperty2
        
        self.created = created
        self.modified = modified
    }
}
