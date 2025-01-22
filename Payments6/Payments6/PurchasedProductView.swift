//
//  PurchasedProductView.swift
//  Payments6
//
//  Created by user270893 on 1/11/25.
//

import SwiftUI
import CoreData

struct PurchasedProductsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    // Pobieramy tylko kupione produkty
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
        predicate: NSPredicate(format: "isPurchased == true"),
        animation: .default
    )
    private var purchasedProducts: FetchedResults<Product>
    
    var body: some View {
        List {
            ForEach(purchasedProducts) { product in
                Text(product.name ?? "Brak nazwy")
            }
        }
        .navigationTitle("Zakupione")
    }
}
