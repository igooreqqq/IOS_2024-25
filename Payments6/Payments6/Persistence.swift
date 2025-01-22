//
//  Persistence.swift
//  Payments6
//
//  Created by user270893 on 1/11/25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "Payments6")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error loading Core Data store: \(error)")
            }
        }
    }
}
