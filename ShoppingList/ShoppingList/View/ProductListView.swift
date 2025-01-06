//
//  ProductListView.swift
//  ShoppingList
//
//  Created by user252224 on 12/14/24.
//

import SwiftUI
import CoreData

struct ProductListView: View {
    @FetchRequest(
        entity: Product.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)]
    ) var products: FetchedResults<Product>
    
    var body: some View {
        NavigationView {
            List(products, id: \.id) { product in
                NavigationLink(destination: ProductDetailView(product: product)) {
                    HStack {
                        Text(product.name ?? "Unknown")
                        Spacer()
                        Text(String(format: "$%.2f", product.price))
                    }
                }
            }
            .navigationTitle("Products")
        }
    }
}
