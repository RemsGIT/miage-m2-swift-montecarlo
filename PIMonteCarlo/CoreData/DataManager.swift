//
//  DataManager.swift
//  PIMonteCarlo
//
//  Created by Rémy Castro on 19/12/2023.
//

import CoreData

class DataManager {
    static let shared = DataManager()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataPi")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    private init() {}
}
