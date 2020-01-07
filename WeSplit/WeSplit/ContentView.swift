//
//  ContentView.swift
//  WeSplit
//
//  Created by Kevin Ngo on 2020-01-03.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2 //index, so 2 means 20% tip
    
    let tipPercentages = [10,15,18,20,0]
    
    var totalPerPerson: Double {
        //default if people left blank is 2
        let peopleCount = Double(numberOfPeople) ?? 2

        let amountPerPerson = totalIncludingTax / peopleCount
        return amountPerPerson
    }
    
    var totalIncludingTax: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        
        return grandTotal
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    TextField("Number of people, default of 2", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                
                Section (header: Text("How much tip do you want to leave?")) {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach( 0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section (header: Text("Total including tax")) {
                    Text("$\(totalIncludingTax)")
                        .foregroundColor(tipPercentages[tipPercentage] == 0 ? .red : .black)

                }
                
                Section (header: Text("Amount per person")){
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
