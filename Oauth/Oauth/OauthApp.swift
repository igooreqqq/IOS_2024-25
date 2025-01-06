//
//  OauthApp.swift
//  Oauth
//
//  Created by user252224 on 1/1/25.
//

import SwiftUI

@main
struct OauthApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
