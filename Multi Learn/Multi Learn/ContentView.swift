//
//  ContentView.swift
//  Multi Learn
//
//  Created by Kevin Ngo on 2020-01-15.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

struct ContentView: View {
    @State private var numQuestions = 0
    
    var body: some View {
        
        NavigationView {
            VStack{
                Stepper(value: $numQuestions, in: 0...50, label: { Text("Questions:  \(numQuestions)")}).padding(60).font(.title)

                
                VStack(spacing:0) {
                    ForEach(0 ..< 4) { row in
                        HStack(spacing: 0) {
                            ForEach(0 ..< 4) { column in
                                NavigationLink(destination: MultiplicationView(numQuestions: self.$numQuestions, multiplicationFactor: (row*4 + column))) {
                                    Text("\(row*4 + column)")
                                        .frame(width: UIScreen.screenWidth/4)
                                        .background(Color.yellow)
                                        
                                        .font(.largeTitle)
                                    
                                }
                                
                                
                                
                                
                            }
                        }
                    }
                .padding()
                    .background(Color.red)
                }
                Spacer()
                
            }
            .navigationBarTitle("Learn Multiplication", displayMode: .inline)
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
