//
//  ContentView.swift
//  Multi Learn
//
//  Created by Kevin Ngo on 2020-01-16.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

struct ContentView: View {
    //make showingHome 2way binding
    //pass the number of questions
    @State private var showingHome = true
    @State private var numberOfQuestionsIndex = 0
    @State private var multiplicand = 0
    @State private var numberOfQuestions:Int = 0
    var numOfQuestionsArray = ["5","10","15","20"]
    
    
    var body: some View {
        NavigationView{
        Group {
            if self.showingHome {
                Group {
                    VStack(spacing:0) {
                        Text("How many questions would you like to be asked?")
                            .padding(.top,(UIScreen.screenHeight/15))
                        
                        Picker(selection: $numberOfQuestionsIndex, label: Text("How many questions?")) {
                            ForEach(0..<numOfQuestionsArray.count) { index in
                                Text(self.numOfQuestionsArray[index]).tag(index)
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                            .padding(.bottom,(UIScreen.screenHeight/25))
                            
                       Text("What multiplication value do you want to practice?")
                        ForEach(0 ..< 4) { row in
                            HStack(spacing: 0) {
                                ForEach(1 ..< 4) { column in
                                    Button(action: {
                                        self.toggleView()
                                        self.multiplicand = (row*3 + column)
                                    }) {
                                        Text("\(row*3 + column)")
                                            .foregroundColor(Color.black)
                                            .frame(width: (UIScreen.screenWidth/3),height:(UIScreen.screenHeight/8))
                                            .background(Color.yellow)
                                            .font(.largeTitle)
                                            .border(Color.black)
                                    }
                                }
                            }
                        }
                        .background(Color.orange)
                        
                        Spacer()
                    }
                    
                    
                }
            }
            else {
                Group {
                    MultiplicationView(numberOfQuestions: numberOfQuestions,
                             multiplicand: multiplicand,
                             showingHome: $showingHome)
                }
            }
        }
        .navigationBarTitle("Multiplication Practice", displayMode: .inline)
    }
    }
    
    func toggleView() {
        showingHome = false
        numberOfQuestions = Int(numOfQuestionsArray[numberOfQuestionsIndex]) ?? 5
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

