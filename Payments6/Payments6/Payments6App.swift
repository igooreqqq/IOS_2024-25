//
//  Payments6App.swift
//  Payments6
//
//  Created by user270893 on 1/11/25.
//

import SwiftUI
import CoreData

@main
struct Payment6App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
