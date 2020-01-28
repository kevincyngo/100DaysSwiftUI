//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Kevin Ngo on 2020-01-27.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI
import Network
struct CheckoutView: View {
    @ObservedObject var order: Order
    
    //states for alert
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    @State private var hasConnection = true
    
    @State private var alertTitle = "Thank you!"
    
    var body: some View {
        GeometryReader {geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your total is $\(self.order.cost, specifier:"%.2f")")
                        .font(.title)
                    
                    Button("Place Order") {
                        
                        self.placeOrderInit()
                    }
                    .padding()
                    
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text(alertTitle),
                  message: Text(confirmationMessage),
                  dismissButton: .default(Text("OK")))
        }
        .onAppear {
            self.listenForConnection()
        }
    }
    
    func listenForConnection() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.hasConnection = true
            } else {
                self.hasConnection = false
            }
        }

        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)

    }
    
    func placeOrderInit() {
        //1. convert current order object into some JSON data that can be sent
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }

        //check for internet connection
        if hasConnection {
            placeOrder(encoded)
        } else {
            alertTitle = "Connection error"
            confirmationMessage = "There was an internet connection issue."
            showingConfirmation = true
        }
    }

    func placeOrder(_ encoded: Data) {
        //2. prepare URLRequest to send our encoded data as JSON
        //we need to attach data in specific way b/c we need to send the HTTP method "GET"
        //and the content type (MIME type)
        //use https://reqres.in/ to test sending data
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        //3. run that request and process the response
        URLSession.shared.dataTask(with: request){ data, response, error in
            // handle the result here.
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.showingConfirmation = true
            } else {
                print("Invalid response from server.")
            }
            
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
