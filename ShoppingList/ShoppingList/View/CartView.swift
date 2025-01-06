//
//  CartView.swift
//  ShoppingList
//
//  Created by user252224 on 12/14/24.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        NavigationView {
            if cartManager.cartItems.isEmpty {
                Text("Your cart is empty!")
                    .font(.headline)
                    .padding()
            } else {
                List(cartManager.cartItems.keys.sorted(by: { $0.name ?? "" < $1.name ?? "" }), id: \.id) { product in
                    HStack {
                        Text(product.name ?? "Unknown")
                        Spacer()
                        Text("x\(cartManager.cartItems[product] ?? 0)")
                    }
                }
                .navigationTitle("Cart")
            }
        }
    }
}
