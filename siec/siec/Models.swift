//
//  Models.swift
//  siec
//
//  Created by user252224 on 12/15/24.
//

import Foundation

struct ProductModel: Codable {
    let id: String
    let name: String
    let price: Double
    let description: String
    let category: String
}

struct CategoryModel: Codable {
    let id: String
    let name: String
}

struct OrderModel: Codable {
    let id: String
    let date: String
    let totalPrice: Double
    let customerName: String
    let products: [String]
}
