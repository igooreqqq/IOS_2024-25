//
//  ShoppingListApp.swift
//  ShoppingList
//
//  Created by user252224 on 12/14/24.
//

import SwiftUI

@main
struct ShoppingListApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var cartManager = CartManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(cartManager)
        }
    }
}
