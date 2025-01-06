//
//  NetworkManager.swift
//  siec
//
//  Created by user252224 on 12/15/24.
//

import Foundation
import CoreData

class NetworkManager {
    static let shared = NetworkManager()

    func fetchOrders(context: NSManagedObjectContext, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:5000/orders") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching orders: \(error)")
                completion(false)
                return
            }

            guard let data = data else {
                print("No data received")
                completion(false)
                return
            }

            do {
                let orders = try JSONDecoder().decode([OrderModel].self, from: data)
                DispatchQueue.main.async {
                    self.saveOrdersToCoreData(orders: orders, context: context)
                    completion(true)
                }
            } catch {
                print("Error decoding orders: \(error)")
                completion(false)
            }
        }.resume()
    }

    private func saveOrdersToCoreData(orders: [OrderModel], context: NSManagedObjectContext) {
        for orderData in orders {
            let order = Order(context: context)
            order.id = UUID(uuidString: orderData.id) ?? UUID()
            order.date = ISO8601DateFormatter().date(from: orderData.date) ?? Date()
            order.totalPrice = orderData.totalPrice
            order.customerName = orderData.customerName

            for productId in orderData.products {
                if let productUUID = UUID(uuidString: productId) {
                    let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
                    fetchRequest.predicate = NSPredicate(format: "id == %@", productUUID as CVarArg)

                    if let product = try? context.fetch(fetchRequest).first {
                        order.addToProducts(product)
                    } else {
                        print("Product with UUID \(productUUID) not found in Core Data.")
                    }
                } else {
                    print("Invalid UUID string: \(productId)")
                }
            }
        }

        do {
            try context.save()
            print("Orders saved successfully")
        } catch {
            print("Error saving orders: \(error)")
        }
    }

}
