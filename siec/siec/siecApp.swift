//
//  siecApp.swift
//  siec
//
//  Created by user252224 on 12/15/24.
//

import SwiftUI

@main
struct siecApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
