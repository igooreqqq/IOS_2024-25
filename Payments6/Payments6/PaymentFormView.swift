//
//  PaymentFormView.swift
//  Payments6
//
//  Created by user270893 on 1/11/25.
//

import SwiftUI
import CoreData

struct PaymentFormView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    let product: Product
    let onPaymentSuccess: () -> Void
    
    @State private var cardNumber = ""
    @State private var cardHolderName = ""
    @State private var expiryDate = ""
    @State private var cvv = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Dane karty")) {
                    TextField("Numer karty", text: $cardNumber)
                        .keyboardType(.numberPad)
                    TextField("Imię i nazwisko", text: $cardHolderName)
                    TextField("Data ważności (MM/YY)", text: $expiryDate)
                    TextField("CVV", text: $cvv)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Kwota do zapłaty")) {
                    Text(String(format: "%.2f zł", product.price))
                }
                
                Button("Zapłać") {
                    makePayment()
                }
            }
            .navigationBarTitle("Płatność", displayMode: .inline)
        }
    }
    
    func makePayment() {
        // Mockowe wywołanie płatności
        let paymentModel = PaymentModel(
            cardNumber: cardNumber,
            cardHolderName: cardHolderName,
            expiryDate: expiryDate,
            cvv: cvv,
            amount: product.price
        )
        
        PaymentService.shared.processPayment(paymentModel: paymentModel) { success in
            if success {
                // Ustawiamy isPurchased na true i zapisujemy w Core Data
                product.isPurchased = true
                do {
                    try viewContext.save()
                } catch {
                    print("Błąd zapisu: \(error.localizedDescription)")
                }
                
                // Wywołanie callbacku i zamknięcie widoku
                onPaymentSuccess()
                presentationMode.wrappedValue.dismiss()
            } else {
                print("Płatność nie powiodła się")
            }
        }
    }
}
