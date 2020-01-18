//
//  GameView.swift
//  Multi Learn
//
//  Created by Kevin Ngo on 2020-01-16.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI

//todo how to put display questionanswer in text

struct QuestionAnswer {
    var multiplicant: Int
    var answer: Int
    
}


struct MultiplicationView: View {
    
    //TODO: logic could be cleaned up
    @State private var solution = ""
    @State private var numberOfCorrect = 0
    let numberOfQuestions: Int
    let multiplicand: Int
    @State var questionsAnswers: [QuestionAnswer] = []
    @Binding var showingHome: Bool
    @State var isGameOver: Bool = false
    
    init(numberOfQuestions: Int, multiplicand: Int, showingHome: Binding<Bool>) {
        self.numberOfQuestions = numberOfQuestions
        self.multiplicand = multiplicand
        self._showingHome = showingHome
    }
    
    var body: some View {
        Group {
            VStack {
                Text("Num correct: \(String(numberOfCorrect))")
                    .foregroundColor(Color.green)
                
                HStack {
                    Spacer()
                    
                    Text("\(String(multiplicand))")
                        .frame(width: (UIScreen.screenWidth/5),height:(UIScreen.screenHeight/8))
                        .font(.system(size: 60))
                        .padding()
                    
                    Spacer()
                    
                    Text("x")
                        .font(.largeTitle)
                    
                    Spacer()
                    
                    Text("\(getMultiplicant())")
                        .frame(width: (UIScreen.screenWidth/5),height:(UIScreen.screenHeight/8))
                        .font(.system(size: 60))
                        .padding()
                    
                    Spacer()
                }.padding()
                .padding(.top, (UIScreen.screenHeight/30))
                
                VStack(spacing: 0) {
                    TextField("Answer", text: $solution)
                        .keyboardType(.numberPad)
                        .padding()
                        .frame(width: (UIScreen.screenWidth),height:(UIScreen.screenHeight/16))
                        .border(Color.black)
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        
                    
                    Button(action: {
                        self.checkAnswer()
                    }){
                        Text("Submit")
                        .font(.title)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                        .border(Color.black)
                    }
                    
                    }.padding()
                    .cornerRadius(5)
                Spacer()
            }
        }.onAppear{
            var multiplicant = 0
            for _ in 0 ..< self.numberOfQuestions {
                multiplicant = Int.random(in: 1..<13)
                self.questionsAnswers.append(QuestionAnswer(multiplicant: multiplicant, answer: multiplicant*self.multiplicand))
            }
        }
        .alert(isPresented: $isGameOver) {
            Alert(title: Text("Game Over"),
                  message: Text("You got \(String(numberOfCorrect))/\(String(numberOfQuestions)) correct."),
                  dismissButton: .default(Text("Confirm")) {
                    self.showingHome = true
                })
        }
    }
    
    func checkAnswer() {
        if Int(solution) == questionsAnswers[0].answer {
            numberOfCorrect += 1
        }
        if questionsAnswers.count > 1 {
            questionsAnswers.remove(at:0)
        } else {
            isGameOver = true
        }
        solution = ""
    }
    
    
    func getMultiplicant() -> String {
        if questionsAnswers.count > 0 {
            return String(questionsAnswers[0].multiplicant)
        }
        return ""
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        MultiplicationView(numberOfQuestions:5, multiplicand: 1, showingHome: .constant(false))
        
    }
}
