//
//  Repository.swift
//  SmartCarrotFramework
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import Foundation
import CoreData

protocol EntityWithId {
    var id : String { get set }
}

internal class Repository<EntityObject>
    where EntityObject : EntityWithId {
    private let _managedContext : NSManagedObjectContext
    
    init() {
        _managedContext = CoreDataStack().viewContext
        
        // to ensure addUpdate, the newest record will overwrite the old one
        _managedContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
    
    /// Must be overwritten, returns respective EntityName from CoreData
    internal func getEntityName() -> String {
        return ""
    }
    
    /// Must be overwritten, coerces a CoreData db object to the real world object
    internal func readEntitiesFromManagedObject(_ data : NSManagedObject) throws -> EntityObject {
        throw CarrotContextError.notImplementedError
    }
    
    /// Must be overwritten, coerces a real world object to the CoreData db object
    internal func mapObjectToNSManagedObject(item: EntityObject, dbObj: inout NSManagedObject) throws {
        throw CarrotContextError.notImplementedError
    }
    
    internal func getAll(where predicate: NSPredicate?) throws -> [EntityObject] {
        var result = [EntityObject]()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: getEntityName())
        if predicate != nil {
            fetchRequest.predicate = predicate
        }

        let test = try _managedContext.fetch(fetchRequest)
        
        for data in test as! [NSManagedObject] {
            result.append(try readEntitiesFromManagedObject(data))
        }
        
        return result
    }
    
    internal func addUpdate(items: [EntityObject]) throws {
        if items.first(where: { $0.id.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }) != nil {
            throw CarrotContextError.emptyEntityId
        }
        
        for item in items {
            let entity = NSEntityDescription.entity(forEntityName: getEntityName(), in: _managedContext)!
            var dbEntity = NSManagedObject(entity: entity, insertInto: _managedContext)
            
            try mapObjectToNSManagedObject(item: item, dbObj: &dbEntity)
        }

        try _managedContext.save()
        postNotifications()
    }
    
    internal func wipe() throws {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: getEntityName())
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        
        try _managedContext.execute(request)
        postNotifications()
    }

    
    internal func delete(items: [EntityObject]) throws {
        for item in items {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: getEntityName())
            fetchRequest.predicate = NSPredicate(format: "id = %@", item.id as NSString)

            let test = try _managedContext.fetch(fetchRequest)
            let objectToDelete = test[0] as! NSManagedObject
            _managedContext.delete(objectToDelete)
        }

        try _managedContext.save()
        postNotifications()
    }
    
    // does nothing, must be overriden to post notifications
    internal func postNotifications() {        
    }
    
    internal func getAll() throws -> [EntityObject] {
        return try getAll(where: nil)
    }
    
    internal func getById(id: String) throws -> EntityObject? {
        let result = try getAll(where: NSPredicate(format: "id = %@", id as NSString))
        return result.count > 0 ? result[0] : nil
    }
    
    // Unwraps optionals and coerses it to Decimal
    // Doesn't throw an exception if this is not possible
    internal func unwrapDecimal(arg: Any?) -> Decimal {
        let optionalDecimal = arg as? Decimal
        if optionalDecimal == nil {
            return 0
        } else {
            return optionalDecimal!
        }
    }
    
    // Unwraps optionals and coerses it to String
    // Doesn't throw an exception if this is not possible
    internal func unwrapString(arg: Any?) -> String {
        let optionalString = arg as? String
        if optionalString == nil {
            return ""
        } else {
            return optionalString!
        }
    }
    
    // Unwraps optionals and coerses it to Date Today
    // Doesn't throw an exception if this is not possible
    internal func unwrapDate(arg: Any?) -> Date {
        let optionalDate = arg as? Date
        if optionalDate == nil {
            return Date()
        } else {
            return optionalDate!
        }
    }
    
    // Unwraps optionals and coerses it to Int
    // Doesn't throw an exception if this is not possible
    internal func unwrapInt(arg: Any?) -> Int {
        let optionalInt = arg as? Int
        if optionalInt == nil {
            return 0
        } else {
            return optionalInt!
        }
    }
}

/// The type used for the names of `CarrotContext` emitted notifications.
public extension Notification.Name {
    /**
     Transaction List Did Update
     */
    static let transactionListDidUpdate = Notification.Name("c".l.underscore.t.r.a.n.s.a.c.t.i.o.n.L.i.s.t.D.i.d.U.p.d.a.t.e)
//    static let transactionListDidUpdate = Notification.Name("cl_transactionListDidUpdate")
    
    /**
     Budget List Did Update
     */
    static let budgetListDidUpdate = Notification.Name("c".l.underscore.b.u.d.g.e.t.L.i.s.t.D.i.d.U.p.d.a.t.e)
//    static let budgetListDidUpdate = Notification.Name("cl_budgetListDidUpdate")
    
    /**
     A Budget Did Exceed its threshold limit
     */
    static let budgetDidAlert = Notification.Name("c".l.underscore.b.u.d.g.e.t.D.i.d.A.l.e.r.t)
//    static let budgetDidAlert = Notification.Name("cl_budgetDidAlert")
    
    /**
     A Budget Did Over Spend
     */
    static let budgetDidOverSpend = Notification.Name("c".l.underscore.b.u.d.g.e.t.D.i.d.O.v.e.r.S.p.e.n.d)
//    static let budgetDidOverSpend = Notification.Name("cl_budgetDidOverSpend")
}
