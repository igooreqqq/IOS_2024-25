//
//  PaymentService.swift
//  Payments6
//
//  Created by user270893 on 1/11/25.
//


import Foundation

class PaymentService {
    static let shared = PaymentService()
    
    private init() {}
    
    let baseURL = "http://127.0.0.1:5000"
    
    func processPayment(paymentModel: PaymentModel, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(baseURL)/pay") else {
            completion(false)
            return
        }
        
        let encoder = JSONEncoder()
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try encoder.encode(paymentModel)
            request.httpBody = jsonData
        } catch {
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Błąd sieci: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let data = data else {
                completion(false)
                return
            }
            
            do {
                if let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let success = jsonDict["success"] as? Bool {
                    completion(success)
                } else {
                    completion(false)
                }
            } catch {
                completion(false)
            }
        }.resume()
    }
}
