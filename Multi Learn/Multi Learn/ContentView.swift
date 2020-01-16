//
//  ContentView.swift
//  Multi Learn
//
//  Created by Kevin Ngo on 2020-01-15.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @State private var numQuestions = 0
    
    var body: some View {
            NavigationView {
                VStack{
                Text("Learn Multiplication")
                    .font(.title)

                Stepper("Enter number of questions", value: $numQuestions, in: 0 ... 50)
                    .padding()

                Text("\(numQuestions) Questions")
                    .padding(.bottom, 50)
                
                
                VStack {
                    ForEach(0 ..< 4) { row in
                        HStack {
                            ForEach(0 ..< 4) { column in
                                NavigationLink(destination: MultiplicationView(numQuestions: self.$numQuestions, multiplicationFactor: (row*4 + column))) {
                                        Text("\(row*4 + column)")
                                            .frame(width: 75, height: 75)
                                            
                                            .background(Color.yellow)
                                            .padding()
                                            
                                            .font(.largeTitle)
                                    .cornerRadius(40)
                                }

                                
                                
                            }
                        }
                    }
                }
                Spacer()
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
