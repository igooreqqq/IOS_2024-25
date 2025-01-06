//
//  ContentView.swift
//  siec
//
//  Created by user252224 on 12/15/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Product.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)]
    ) private var products: FetchedResults<Product>

    @FetchRequest(
        entity: Category.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)]
    ) private var categories: FetchedResults<Category>

    @FetchRequest(
        entity: Order.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Order.date, ascending: false)]
    ) private var orders: FetchedResults<Order>

    @State private var isLoading = true
    @State private var showAddProductView = false
    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView("Loading data...")
                } else {
                    List {
                        Section(header: Text("Products")) {
                            ForEach(products) { product in
                                VStack(alignment: .leading) {
                                    Text(product.name ?? "Unknown")
                                        .font(.headline)
                                    Text("Price: $\(product.price, specifier: "%.2f")")
                                        .font(.subheadline)
                                    if let categoryName = product.category?.name {
                                        Text("Category: \(categoryName)")
                                            .font(.caption)
                                    }
                                }
                            }
                        }

                        Section(header: Text("Categories")) {
                            ForEach(categories) { category in
                                VStack(alignment: .leading) {
                                    Text(category.name ?? "Unknown")
                                        .font(.headline)
                                    Text("Products: \(category.products?.count ?? 0)")
                                        .font(.subheadline)
                                }
                            }
                        }

                        Section(header: Text("Orders")) {
                            ForEach(orders) { order in
                                VStack(alignment: .leading) {
                                    Text("Customer: \(order.customerName ?? "Unknown")")
                                        .font(.headline)
                                    Text("Date: \(order.date?.formatted() ?? "Unknown")")
                                        .font(.subheadline)
                                    Text("Total Price: $\(order.totalPrice, specifier: "%.2f")")
                                        .font(.subheadline)

                                    if let products = order.products as? Set<Product> {
                                        Text("Products: \(products.map { $0.name ?? "Unknown" }.joined(separator: ", "))")
                                            .font(.caption)
                                    }
                                }
                            }
                        }
                    }
                }

                Button(action: {
                    showAddProductView.toggle()
                }) {
                    Text("Add Product")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                }
                .sheet(isPresented: $showAddProductView) {
                    AddProductView()
                        .environment(\.managedObjectContext, viewContext)
                }
            }
            .navigationTitle("Products, Categories & Orders")
            .onAppear {
                loadData()
            }
        }
    }

    private func loadData() {
        

        NetworkManager.shared.fetchOrders(context: viewContext) { success in
            DispatchQueue.main.async {
                self.isLoading = !success
            }
        }
    }
}
