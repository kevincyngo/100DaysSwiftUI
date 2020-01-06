//
//  ContentView.swift
//  UnitConverter
//
//  Created by Kevin Ngo on 2020-01-03.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var firstUnit = 0
    @State var secondUnit = 0
    @State var firstUnitValue = ""
    
    
    
    let units = ["m", "km", "ft", "in"]
    
    //Can also always convert the first value into, say meters
    //And we return the value from meters to the second unit
    var convertedValue: Double {
        let unitValue = Double(firstUnitValue) ?? 0
        let conversionUnits = (units[firstUnit], units[secondUnit])
        switch conversionUnits {
        case ("m", "m"), ("km","km"), ("ft", "ft"), ("in", "in"):
            return unitValue
        case("m","km"): return unitValue/1000
        case("m", "ft"): return unitValue*3.281
        case("m", "in"): return unitValue*39.37
            
        case("km", "ft"): return unitValue*3281
        case("km", "in"): return unitValue*39370
        case("km","m"): return unitValue*1000

        case("ft","in"): return unitValue*12
        case("ft","m"): return unitValue/3.281
        case("ft","km"): return unitValue/3281

        case("in","ft"): return unitValue/12
        case("in", "m"): return unitValue/39.37
        case("in", "km"): return unitValue/39370
            
        default: return 0
        }
    }
    
    var body: some View {
        NavigationView {
            
            Form {
                Section (header:Text("Enter unit for conversion")) {
                    TextField("Enter a value", text: $firstUnitValue)
                        .keyboardType(.decimalPad)
                    
                    
                    
                    Picker("Units", selection: $firstUnit) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }
                .pickerStyle(SegmentedPickerStyle())
                }
                
                Section (header:Text("Enter unit for conversion")) {
                    Text("\(convertedValue, specifier: "%.7f")")
                    
                    
                    Picker("Units", selection: $secondUnit) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }
                .pickerStyle(SegmentedPickerStyle())
                }
                
            }

        .navigationBarTitle("Unit Converter")
            
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
