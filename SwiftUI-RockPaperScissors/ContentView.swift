//
//  ContentView.swift
//  SwiftUI-RockPaperScissors
//
//  Created by JimmyChao on 2024/3/14.
//

import SwiftUI
import Foundation

enum MoveSets: String {
    case rock = "Rock"
    case paper = "Papper"
    case scissors = "Scissors"
    
    var winSenario: MoveSets {
        switch self {
        case .rock:
            return .scissors
        case .paper:
            return .rock
        case .scissors:
            return .paper
        }
    }
    
    var looseSenario: MoveSets {
        switch self {
        case .rock:
            return .paper
        case .paper:
            return .scissors
        case .scissors:
            return .rock
        }
    }
}

struct ContentView: View {
    
    var opponentMove: MoveSets {
        moveSets[randIndex]
    }
    
    @State private var randIndex = Int.random(in: 0...2)
    @State private var moveSets: [MoveSets] = [.rock, .paper, .scissors]
    @State var alertTitle = ""
    @State var alertMessage = ""
    @State var shouldWin = true
    @State private var score = 0
    @State private var round = 0
    @State var showAlert = false
    
    var body: some View {
        ZStack {
            
            LinearGradient(
                colors: [.blue, .green],
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack(spacing: 10) {
                Spacer()
                Text("Rock Paper Scissors").font(.largeTitle.weight(.heavy))
                Spacer()
                Text("The opponent is \(moveSets[randIndex].rawValue)")
                
                Text("You should \(shouldWin ? "win": "loose")")
                
                VStack(spacing: 55) {
                    ForEach(moveSets, id: \.self) { myMove in
                        Button(myMove.rawValue) {
                            moveTapped(with: myMove)
                        }
                    }
                }
                .font(.system(size: 40, weight: .bold, design: .monospaced))
                .frame(maxWidth: .infinity, maxHeight: 300)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .padding()
                
                Text("Score is now: \(score)").font(.title)
                Spacer()
            }
        }.alert(alertTitle, isPresented: $showAlert) {
            
            Button("Okay") {
                refresh()
            }
            
        } message: {
            Text(alertMessage)
        }

    }
    
    // Restart
    func shouldStartNewRound() {
        if round > 2 {
            alertTitle = "Game Over"
            alertMessage = "Your total score is \(score)"
            score = 0
            round = 0
            showAlert = true
        }
    }
    
    // Refresh or Ask Question
    func refresh() {
        randIndex = Int.random(in: 0...2)
        moveSets.shuffle()
        shouldWin = Bool.random()
    }
    
    // Handel move tapped
    func moveTapped(with myMove: MoveSets) {
        
        // Determine the result
        if myMove == opponentMove {
            
            alertTitle = "Tie!!!"
            alertMessage = "You are suppose to \(shouldWin ? "win": "loose")"
            score -= 1
            
        } else {
            
            switch shouldWin {
            case true:
                
                if myMove == opponentMove.looseSenario {
                    
                    alertTitle = "You Win!!!"
                    alertMessage = "Well done"
                    score += 1
                } else {
                    alertTitle = "You loose!!!"
                    alertMessage = "You should use \(opponentMove.looseSenario) to win"
                    score -= 1
                }
                
            default:
                
                if myMove == opponentMove.winSenario {
                    alertTitle = "You loose!!! but in a good way"
                    alertMessage = "Well done"
                    score += 1
                } else {
                    alertTitle = "You win!!!! but you shouldn't"
                    alertMessage = "You should use \(opponentMove.winSenario) to loose"
                    score -= 1
                }
            }
        }
        
        round += 1
        shouldStartNewRound()
        showAlert = true
        
        
    }
}

#Preview {
    ContentView()
}
