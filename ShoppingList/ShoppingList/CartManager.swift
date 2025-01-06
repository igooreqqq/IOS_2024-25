//
//  CartManager.swift
//  ShoppingList
//
//  Created by user252224 on 12/14/24.
//

import Foundation

class CartManager: ObservableObject {
    @Published var cartItems: [Product: Int] = [:]
    
    func addToCart(_ product: Product) {
        cartItems[product, default: 0] += 1
    }
    
    func removeFromCart(_ product: Product) {
        guard let count = cartItems[product], count > 1 else {
            cartItems[product] = nil
            return
        }
        cartItems[product] = count - 1
    }
    
    func clearCart() {
        cartItems.removeAll()
    }
}
