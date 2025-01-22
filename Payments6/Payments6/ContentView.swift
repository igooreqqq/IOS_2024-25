//
//  ContentView.swift
//  Payments6
//
//  Created by user270893 on 1/11/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
        animation: .default
    )
    private var products: FetchedResults<Product>
    
    @State private var selectedProduct: Product?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(products) { product in
                    HStack {
                        Text(product.name ?? "Brak nazwy")
                        Spacer()
                        Text(String(format: "%.2f zł", product.price))
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if !product.isPurchased {
                            selectedProduct = product
                        }
                    }
                    .foregroundColor(product.isPurchased ? .gray : .primary)
                }
            }
            .navigationTitle("Lista produktów")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Dodaj testowe") {
                        addSampleProducts()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink("Zakupione") {
                        PurchasedProductsView()
                    }
                }
            }
        }
        .sheet(item: $selectedProduct) { product in
            PaymentFormView(product: product) {

            }
        }
    }
    
    private func addSampleProducts() {
        let names = ["Produkt A", "Produkt B", "Produkt C"]
        for name in names {
            let newProduct = Product(context: viewContext)
            newProduct.id = UUID()
            newProduct.name = name
            newProduct.price = Double.random(in: 10...100)
            newProduct.isPurchased = false
        }
        
        do {
            try viewContext.save()
        } catch {
            print("Błąd zapisu: \(error.localizedDescription)")
        }
    }
}
