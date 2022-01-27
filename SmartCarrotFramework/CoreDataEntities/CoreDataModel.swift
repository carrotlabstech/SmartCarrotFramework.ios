//
//  CoreDataModel.swift
//  SmartCarrotFramework
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import Foundation
import CoreData

// https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreData/InitializingtheCoreDataStack.html#//apple_ref/doc/uid/TP40001075-CH4-SW1
// there is a mistake in the description:
// var managedObjectContext: NSManagedObjectContext is used instead of
// var persistentContainer: NSPersistentContainer wr

// differences between ios 9 & ios10 here: https://swifting.io/blog/2016/09/25/25-core-data-in-ios10-nspersistentcontainer/
internal final class CoreDataStack {
 
    static let shared = CoreDataStack()
    private var errorHandler: (Error) -> Void = {_ in }
    
    //#1
    lazy var persistentContainer: NSPersistentContainer = {
        let momdName = "CoreDataModel"

        guard let modelURL = Bundle(for: type(of: self)).url(forResource: momdName, withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }

        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }

        let container = NSPersistentContainer(name: momdName, managedObjectModel: mom)
        
//        let container = NSPersistentContainer(name: "CodeDataModel")
        container.loadPersistentStores(completionHandler: { [weak self](storeDescription, error) in
            if let error = error {
                self?.errorHandler(error)
            }
            })
        return container
    }()
    
    //#2
    lazy var viewContext: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    //#3
    // Optional
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    //#4
    func performForegroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        self.viewContext.perform {
            block(self.viewContext)
        }
    }
    
    //#5
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        self.persistentContainer.performBackgroundTask(block)
    }
}

