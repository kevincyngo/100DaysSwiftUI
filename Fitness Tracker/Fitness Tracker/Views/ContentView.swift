//
//  ContentView.swift
//  Fitness Tracker
//
//  Created by Kevin Ngo on 2020-01-21.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var workouts: [Workout] = []
    @State private var name: String = ""
    
    @State private var isAddPresented = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(self.workouts) { workout in
                        NavigationLink(destination: Text("\(workout.name)")) {
                                Text("\(workout.name)")
                        }
                        
                    }
                }
                
                Form {
                    TextField("Enter workout name", text: $name)
                    
                    Button(action: {
                        self.SubmitForm()
                    }) {
                        Text("Submit")
                    }
                }
            }
            .navigationBarItems(trailing:
                Button("Add workout") {
                    self.isAddPresented = true
                }
            )
            .sheet(isPresented: $isAddPresented,
                onDismiss: { self.isAddPresented = false }) {
                     AddWorkoutView()
                 }
            .navigationBarTitle("TT")
        }

    }
    func SubmitForm() {
        self.workouts.append(Workout(name: self.name))
        self.name = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
