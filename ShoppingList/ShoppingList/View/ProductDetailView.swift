//
//  ProductDetailView.swift
//  ShoppingList
//
//  Created by user252224 on 12/14/24.
//
import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @EnvironmentObject var cartManager: CartManager

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(product.name ?? "Unknown")
                .font(.largeTitle)
                .bold()

            Text(product.details ?? "No details available.")
                .font(.body)

            Text(String(format: "Price: $%.2f", product.price))
                .font(.headline)

            Spacer()

            Button(action: {
                cartManager.addToCart(product)
            }) {
                Text("Add to Cart")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .navigationTitle("Product Details")
    }
}

