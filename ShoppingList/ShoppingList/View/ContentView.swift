//
//  ContentView.swift
//  ShoppingList
//
//  Created by user252224 on 12/14/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        TabView {
            ProductListView()
                .tabItem {
                    Label("Products", systemImage: "list.dash")
                }

            CartView()
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
        }
    }
}
