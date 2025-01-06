//
//  DataSeeder.swift
//  ShoppingList
//
//  Created by user252224 on 12/14/24.
//

import CoreData

struct DataSeeder {
    static func seed(context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        
        if (try? context.count(for: fetchRequest)) ?? 0 > 0 {
            return
        }
        
        let fruits = Category(context: context)
        fruits.id = UUID()
        fruits.name = "Fruits"
        
        let vegetables = Category(context: context)
        vegetables.id = UUID()
        vegetables.name = "Vegetables"
        
        let apple = Product(context: context)
        apple.id = UUID()
        apple.name = "Apple"
        apple.details = "A fresh red apple."
        apple.price = 0.99
        apple.category = fruits
        
        let carrot = Product(context: context)
        carrot.id = UUID()
        carrot.name = "Carrot"
        carrot.details = "A crunchy orange carrot."
        carrot.price = 0.59
        carrot.category = vegetables
        
        do {
            try context.save()
        } catch {
            print("Error seeding data: \(error)")
        }
    }
}
