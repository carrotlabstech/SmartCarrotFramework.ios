//
//  BudgetRepository.swift
//  SmartCarrotFramework
//
//  Copyright © 2020 CarrotLabs gmbh. All rights reserved.
//

import Foundation
import CoreData

internal class BudgetRepository : Repository<Budget> {
    typealias EntityObject = Budget
    
    internal override func getEntityName() -> String {
        return "BudgetEntity"
    }
    
    internal override func readEntitiesFromManagedObject(_ data : NSManagedObject) -> EntityObject {
        return Budget(id: unwrapString(arg: data.value(forKey: "id")),
                         externalId: data.value(forKey: "externalId") as? String,
                         currency: data.value(forKey: "currency") as? String,
                         accountId: data.value(forKey: "accountId") as? String,
                         name: unwrapString(arg: data.value(forKey: "name")),
                         budgeted: unwrapDecimal(arg: data.value(forKey: "budgeted")),
                         alert: unwrapDecimal(arg: data.value(forKey: "alert")),
                         categoryId: unwrapInt(arg: data.value(forKey: "categoryId")),
                         frequencyType: unwrapInt(arg: data.value(forKey: "frequencyType")) == 2 ? .annual : .monthly)

    }
    
    internal override func mapObjectToNSManagedObject(item: EntityObject, dbObj: inout NSManagedObject) {
        dbObj.setValue(item.id, forKey: "id")
        dbObj.setValue(item.externalId, forKey: "externalId")
        dbObj.setValue(item.accountId, forKey: "accountId")
        dbObj.setValue(item.accountId, forKey: "currency")
        dbObj.setValue(item.budgeted, forKey: "budgeted")
        dbObj.setValue(item.alert, forKey: "alert")
        dbObj.setValue(item.categoryId, forKey: "categoryId")
        dbObj.setValue(item.name, forKey: "name")
        
        dbObj.setValue(item.frequencyType == BudgetFrequency.monthly ? 1 : 2, forKey: "frequencyType")
    }
    
    internal override func postNotifications() {
        NotificationCenter.default.post(name: .budgetListDidUpdate, object: nil)
    }
}
