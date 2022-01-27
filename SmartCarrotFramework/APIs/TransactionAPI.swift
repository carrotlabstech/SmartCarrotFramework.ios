//
//  TransactionAPI.swift
//  SmartCarrotFramework
//
//  Copyright © 2020 CarrotLabs gmbh. All rights reserved.
//

import Foundation

/**
 A `TransactionAPI` implements all the storage and categorisation functions on Transaction.
 
 The object of the class cannot be explicitly instantiated, please call `CarrotContext.getTransactionAPI()` for that.
 */
public final class TransactionAPI : ModuleAPI {
    private let _repository = TransactionRepository()
    private let _categoriser: CategorisationAPI?
    
    internal init(categoriser: CategorisationAPI, credentials: CarrotCredentials?) throws {
        _categoriser = categoriser
        
        super.init(modules: [LicenseDecoder.MODULE_TRANSACTIONS], credentials: credentials)
        
        try validateSettings()
    }
    
    // MARK: - CRUD
    /**
     Adds or updates an array of `Transaction`s.
     
     if a transaction is already categorised, then it will be still recategorised. The method uses `Transaction.id` to determine whether the transaction is already present in the persistent storage and must be updated.
     
     - Parameter transactions: an array of transactions to be updated or inserted.
     - Parameter categorise: whether the transactions must be categorised before saving into the persistent storage.
     */
    public func upsert(transactions: [Transaction], categorise: Bool = true) throws {
        try validateSettings()
        if categorise {
            try self.categorise(transactions: transactions)
        } else {
            try _repository.addUpdate(items: transactions)
        }
    }
    
    /**
     Deletes an array of `Transaction`s from the persistent storage. The method uses `Transaction.id` to identify a transaction to be deleted.
     
     - Parameter transactions: - an array of transactions to be deleted from the persistent storage.
     */
    public func delete(transactions: [Transaction]) throws {
        try validateSettings()
        return try _repository.delete(items: transactions)
    }
    
    /// Returns all transactions. `Transaction`s list is unsorted.
    public func getAll() throws -> [Transaction] {
        try validateSettings()
        return try _repository.getAll()
    }
    
    /** Returns all transactions from the persistent storage, sorted.
     
     Returns all transactions, ordered by: (in order of priority)
        - `BookingDate` desc,
        - `BookingText` asc,
        - `id`asc
    */
    public func getAllOrderByDateDescTextId() throws -> [Transaction] {
        return try getAll().sorted {
            if $0.bookingDate != $1.bookingDate {
               return $0.bookingDate >= $1.bookingDate
            } else if $0.bookingText != $1.bookingText {
                return $0.bookingText < $1.bookingText
            } else {
                return $0.id < $1.id
            }
        }
    }
    
    /**
     Returns a transaction by it's `id`. Returns `nil` if there is no transaction with such an `id` in the persistent storage.
     
     - Parameter id: transaction id to look for.
    */
    public func getById(id: String) throws -> Transaction? {
        try validateSettings()
        return try _repository.getById(id: id)
    }
    
    // MARK: - Categorise
    /**
     Categorises an array of transactions and updates them in the persistent storage
     
     - Parameter transactions: an array of transactions to be categorised.
     
     - Returns: An array of categorised transactions, saved into the persistent storage.
     */
    public func categorise(transactions: [Transaction]) throws -> [Transaction] {
        try validateSettings()
        
        var categorisedTxs = [Transaction]()
        
        for transaction in transactions {
            var categorisedTx = transaction
            categorisedTx.categoryId = try _categoriser!.categorise(description: transaction.bookingText, amount: transaction.amount, isPersonal: CategorisationType.personal)
            categorisedTxs.append(categorisedTx)
        }
        
        try _repository.addUpdate(items: categorisedTxs)
        
        let idsList = categorisedTxs.map { $0.id }
        return try _repository.getAll(where: NSPredicate(format: "ANY id IN %@", idsList))
    }
    
    /**
     Categorises a transaction and updates it in the persistent storage
     
     - Parameter transaction: a transaction to be categorised
     
     - Returns: a categorised transaction from the persistent storage
     */
    public func categorise(transaction: Transaction) throws -> Transaction {
        return try categorise(transactions: [transaction])[0]
    }
    
    // MARK: - Private methods
    internal override func validateSettings() throws {
        try super.validateSettings()
        
        if _categoriser == nil {
            throw CarrotContextError.failedToLoadModel
        }
        
        if SharedContext.shared.key.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
            throw CarrotContextError.encryptionKeyNotSetError
        }
        
        if SharedContext.shared.iv.trimmingCharacters(in: .whitespacesAndNewlines).count != 16 {
            throw CarrotContextError.encryptionInvalidInitialisationVectorError
        }
    }
}
