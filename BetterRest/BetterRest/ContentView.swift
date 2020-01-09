//
//  ContentView.swift
//  BetterRest
//
//  Created by Kevin Ngo on 2020-01-08.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 0
    
    //static means it belongs to the ContentView and not a specific instance
    //This means defaultWakeTime can be read whenever we want, b/c it doesn't
    //rely on the existence of any other properties.
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section (header:Text("When do you want to wake up?").font(.headline)) {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                Section (header:Text("Desired amount of sleep").font(.headline)) {
                    Stepper(value: $sleepAmount, in: 4...12, step:0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                
                Section (header:Text("Daily coffee intake").font(.headline)) {
                    Picker("Daily coffee intake", selection: $coffeeAmount) {
                        ForEach(0 ... 20, id: \.self) {amount in
                            Text(amount == 1 ? "1 cup" : "\(amount) cups")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .labelsHidden()
                }
                
                Section(header: Text("Calculated bedtime").font(.headline)) {
                    Text(calculateBedtime())
                }
            }
        .navigationBarTitle("BetterRest")
        }
    }
    
    func calculateBedtime() -> String {
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        //make prediction
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            //DateFormatter can format dates and times.
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return formatter.string(from: sleepTime)
        } catch {
            return "Sorry, there was a problem calculating your bedtime."
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
