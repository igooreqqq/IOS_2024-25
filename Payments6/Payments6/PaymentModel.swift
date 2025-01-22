//
//  PaymentModel.swift
//  Payments6
//
//  Created by user270893 on 1/11/25.
//

import Foundation

struct PaymentModel: Codable {
    var cardNumber: String
    var cardHolderName: String
    var expiryDate: String
    var cvv: String
    var amount: Double
}
