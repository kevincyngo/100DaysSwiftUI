//
//  ContentView.swift
//  BucketList
//
//  Created by Kevin Ngo on 2020-02-14.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI
import LocalAuthentication
import MapKit

struct ContentView: View {
    @State private var locations:[CodableMKPointAnnotation] = []
    @State private var isUnlocked = false
    @State private var isAuthFailed = false
    
    var body: some View {
        ZStack {
            if isUnlocked {
                DetailsView(locations: self.$locations)
            } else {
                Button("Unlock Places") {
                    self.authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }.onAppear(perform: loadData)
        .alert(isPresented: $isAuthFailed) {
            Alert(title: Text("Auth fail"),
                  message: Text("Biometric authentication failed."),
                  dismissButton: .default(Text("Okay, bye!")) {
                // edit this place
                print("EDITING?")
                
                })
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        // error
                    }
                }
            }
        } else {
            // no biometrics
            self.isAuthFailed = true

        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData() {
        let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")

        do {
            let data = try Data(contentsOf: filename)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("Unable to load saved data.")
        }
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
