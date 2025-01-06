//
//  ContentView.swift
//  Oauth
//
//  Created by user252224 on 1/1/25.
//

import SwiftUI

struct ContentView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var message: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Login app")
                .font(.largeTitle)
                .padding(.top, 50)

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .padding(.horizontal, 40)

            SecureField("Hasło", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 40)

            HStack {
                Button("Zarejestruj się") {
                    registerUser(email: email, password: password)
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)

                Button("Zaloguj się") {
                    loginUser(email: email, password: password)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }

            Text(message)
                .padding()
                .foregroundColor(.red)
        }
    }

    func registerUser(email: String, password: String) {
        guard let url = URL(string: "http://127.0.0.1:5000/register") else {
            message = "Nieprawidłowy URL"
            return
        }

        let body: [String: Any] = [
            "email": email,
            "password": password
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body)

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        message = "Błąd: \(error.localizedDescription)"
                    }
                    return
                }

                guard let data = data else {
                    DispatchQueue.main.async {
                        message = "Brak danych w odpowiedzi."
                    }
                    return
                }

                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 201 {
                        // Sukces
                        if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                           let jsonDict = jsonObject as? [String: Any],
                           let msg = jsonDict["message"] as? String {
                            DispatchQueue.main.async {
                                message = "Sukces: \(msg)"
                            }
                        } else {
                            DispatchQueue.main.async {
                                message = "Rejestracja udana (ale brak wiadomości)"
                            }
                        }
                    } else {
                        // Jakiś błąd
                        if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                           let jsonDict = jsonObject as? [String: Any],
                           let errorMsg = jsonDict["error"] as? String {
                            DispatchQueue.main.async {
                                message = "Błąd: \(errorMsg)"
                            }
                        } else {
                            DispatchQueue.main.async {
                                message = "Błąd nieznany (status code: \(httpResponse.statusCode))"
                            }
                        }
                    }
                }
            }.resume()

        } catch {
            message = "Błąd encji JSON: \(error.localizedDescription)"
        }
    }

    func loginUser(email: String, password: String) {
        guard let url = URL(string: "http://127.0.0.1:5000/login") else {
            message = "Nieprawidłowy URL"
            return
        }

        let body: [String: Any] = [
            "email": email,
            "password": password
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body)

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        message = "Błąd: \(error.localizedDescription)"
                    }
                    return
                }

                guard let data = data else {
                    DispatchQueue.main.async {
                        message = "Brak danych w odpowiedzi."
                    }
                    return
                }

                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        // Sukces - zalogowano
                        if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                           let jsonDict = jsonObject as? [String: Any],
                           let msg = jsonDict["message"] as? String {
                            DispatchQueue.main.async {
                                message = "Sukces: \(msg)"
                            }
                        } else {
                            DispatchQueue.main.async {
                                message = "Zalogowano (ale brak wiadomości)"
                            }
                        }
                    } else {
                        // Błąd
                        if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                           let jsonDict = jsonObject as? [String: Any],
                           let errorMsg = jsonDict["error"] as? String {
                            DispatchQueue.main.async {
                                message = "Błąd: \(errorMsg)"
                            }
                        } else {
                            DispatchQueue.main.async {
                                message = "Błąd nieznany (status code: \(httpResponse.statusCode))"
                            }
                        }
                    }
                }
            }.resume()

        } catch {
            message = "Błąd encji JSON: \(error.localizedDescription)"
        }
    }
}
