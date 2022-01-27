//
//  TransactionRepository.swift
//  SmartCarrotFramework
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import Foundation
import CoreData

internal class TransactionRepository : Repository<Transaction> {
    typealias EntityObject = Transaction
    
    internal override func getEntityName() -> String {
        return "TransactionEntity"
    }
    
    internal override func readEntitiesFromManagedObject(_ data : NSManagedObject) -> EntityObject {
        return Transaction(id: unwrapString(arg: data.value(forKey: "id")),
                            externalId: data.value(forKey: "externalId") as? String,
                            amount: unwrapDecimal(arg: data.value(forKey: "amount")),
                            currency: unwrapString(arg: data.value(forKey: "currency")),
                            sourceAmount: data.value(forKey: "sourceAmount") as? Decimal,
                            sourceCurrency: data.value(forKey: "sourceCurrency") as? String,
                            sourceExchangeRate: data.value(forKey: "sourceExchangeRate") as? Decimal,
                            bookingText: unwrapString(arg: data.value(forKey: "bookingText")),
                            bookingDate: unwrapDate(arg: data.value(forKey: "bookingDate")),
                            valueDate: data.value(forKey: "valueDate") as? Date,
                            categoryId: data.value(forKey: "categoryId") as? Int,
                            userCategoryId: data.value(forKey: "userCategoryId") as? Int,
                            accountId: data.value(forKey: "accountId") as? String,
                            userNote: data.value(forKey: "userNote") as? String,
                            customProperty1: data.value(forKey: "customProperty1") as? String,
                            customProperty2: data.value(forKey: "customProperty2") as? String,
                            created: data.value(forKey: "created") as? Date,
                            modified: data.value(forKey: "modified") as? Date)
    }
    
    internal override func mapObjectToNSManagedObject(item: EntityObject, dbObj: inout NSManagedObject) {
        dbObj.setValue(item.id, forKey: "id")
        dbObj.setValue(item.externalId, forKey: "externalId")
        dbObj.setValue(item.amount, forKey: "amount")
        dbObj.setValue(item.currency, forKey: "currency")
        dbObj.setValue(item.sourceAmount, forKey: "sourceAmount")
        dbObj.setValue(item.sourceCurrency, forKey: "sourceCurrency")
        dbObj.setValue(item.sourceExchangeRate, forKey: "sourceExchangeRate")
        dbObj.setValue(item.bookingText, forKey: "bookingText")
        dbObj.setValue(item.bookingDate, forKey: "bookingDate")
        dbObj.setValue(item.valueDate, forKey: "valueDate")
        dbObj.setValue(item.categoryId, forKey: "categoryId")
        dbObj.setValue(item.userCategoryId, forKey: "userCategoryId")
        dbObj.setValue(item.accountId, forKey: "accountId")
        dbObj.setValue(item.userNote, forKey: "userNote")
        dbObj.setValue(item.customProperty1, forKey: "customProperty1")
        dbObj.setValue(item.customProperty2, forKey: "customProperty2")
        dbObj.setValue(item.created, forKey: "created")
        dbObj.setValue(item.modified, forKey: "modified")
    }
    
    internal override func postNotifications() {
        NotificationCenter.default.post(name: .transactionListDidUpdate, object: nil)
    }    
}
