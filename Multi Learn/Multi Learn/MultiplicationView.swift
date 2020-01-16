//
//  MultiplicationView.swift
//  Multi Learn
//
//  Created by Kevin Ngo on 2020-01-15.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI

struct MultiplicationView: View {
    @Binding var numQuestions: Int
    @State var multiplicationFactor: Int
    var body: some View {
        VStack {
            Text("Questions Remaining: \(numQuestions)")
            Text("Multiplication Factor: \(multiplicationFactor)")
            Button(action: {
                self.numQuestions -= 1
            }) {
                Text("chng")
            }
        }
    }
    
    //returns the (multiplicand, solution)
    func createEquation() -> (Int, Int) {
        let randomInt = Int.random(in: 1..<15)
        let solution = multiplicationFactor * randomInt
        return (randomInt, solution)
    }
}

struct MultiplicationView_Previews: PreviewProvider {
    static var previews: some View {
        MultiplicationView(numQuestions: .constant(4), multiplicationFactor: 4)
    }
}
