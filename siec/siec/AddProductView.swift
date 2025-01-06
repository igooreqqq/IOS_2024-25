//
//  AddProductView.swift
//  siec
//
//  Created by user252224 on 12/15/24.
//
import SwiftUI
import CoreData

struct AddProductView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var name: String = ""
    @State private var price: Double = 0.0
    @State private var description: String = ""
    @State private var selectedCategory: Category?

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Price", value: $price, formatter: NumberFormatter())
                TextField("Description", text: $description)

                Button("Add Product") {
                    let newProduct = Product(context: viewContext)
                    newProduct.id = UUID()
                    newProduct.name = name
                    newProduct.price = price
                    newProduct.descriptionn = description
                    newProduct.category = selectedCategory

                    do {
                        try viewContext.save()
                    } catch {
                        print("Error saving product: \(error)")
                    }
                }
            }
            .navigationTitle("Add Product")
        }
    }
}
