//
//  CoreDataStack.swift
//  NewsApp
//
//  Created by tarek ahmed on 21/06/2024.
//

import CoreData

struct CoreDataStack {
    
    static let shared = CoreDataStack()
    let persistentContainer: NSPersistentContainer
    
    static var preview: CoreDataStack = {
        let result = CoreDataStack(inMemory: true)
        return result
    }()

    private init(inMemory: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "NewsApp")
        if inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true 
    }
    
}
