//
//  GuessTheFlag.swift
//  WeSplit
//
//  Created by Baris Ciftci on 30/12/2023.
//

import SwiftUI

struct GuessTheFlag: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    
    var body: some View {
        ZStack {
            
            LinearGradient(colors: [.blue, .black], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                VStack {
                    Text("Score: \(score)")
                        .foregroundStyle(.white)
                        .bold()
                    
                    Text("Tap the flag of")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                    
                    Text(countries[correctAnswer])
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                }
                
                ForEach(0..<3) { number in
                    Button(action: {
                            flagTapped(number)
                        },label: {
                        Image(countries[number])
                                .cornerRadius(12)
                                .padding(4)
                                .background(.white)
                                .cornerRadius(16)
                    })
                }
            }
        }
        
        .alert(scoreTitle, isPresented: $showScore) {
            Button("Continue", action: askQuestion)
        }message: {
            Text("your score is \(score)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
            score -= 1
        }
        
        showScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    GuessTheFlag()
}
