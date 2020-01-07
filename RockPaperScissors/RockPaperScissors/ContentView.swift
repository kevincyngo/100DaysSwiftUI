//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Kevin Ngo on 2020-01-07.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let moves = ["Rock", "Paper", "Scissors"]
    
    @State private var opponentMove = Int.random(in: 0 ..< 3)
    @State private var isWin = Bool.random()
    
    @State private var score = 0
    
    @State private var didWin = false
    
    var body: some View {
        VStack {
            Text("Score: \(score)")
                .padding(.bottom, 50)
            
            Text("opponent move: \(moves[opponentMove])")
            
            Text("player: \(isWin ? "Win" : "Lose")")
                .padding(.bottom, 30)
            
            HStack(spacing: 15) {
                Button(action: {
                    self.checkCorrect(0)
                }){
                    Text(moves[0])
                }
                Button(action: {
                    self.checkCorrect(1)
                }){
                    Text(moves[1])
                }
                Button(action: {
                    self.checkCorrect(2)
                }){
                    Text(moves[2])
                }
            }
        }
        .alert(isPresented: $didWin) {
            Alert(title: Text("You win!"),
                  message: Text("You reached 10 points."),
                  dismissButton: .default(Text("Restart")) {
                    self.restart()
                })
        }
    }
    
    func restart() {
        didWin = false
        score = 0
        opponentMove = Int.random(in: 0 ..< 3)
        isWin = Bool.random()
    }
    
    func checkCorrect(_ playerChoice: Int) {
        if isWin && ((opponentMove == 0 && playerChoice == 1) ||
                (opponentMove == 1 && playerChoice == 2) ||
                (opponentMove == 2 && playerChoice == 0)) {
                opponentMove = Int.random(in: 0 ..< 3)
                isWin = Bool.random()
                score += 1
    
        }
        else if !isWin && (opponentMove == 0 && playerChoice == 2) ||
                (opponentMove == 1 && playerChoice == 0) ||
                (opponentMove == 2 && playerChoice == 1) {
                opponentMove = Int.random(in: 0 ..< 3)
                isWin = Bool.random()
                score += 1
            
        }
        else {
            opponentMove = Int.random(in: 0 ..< 3)
            isWin = Bool.random()
            if (score != 0) {
                score -= 1
            }
        }
        
        if (score == 10) {
            didWin = true
        }
        
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
