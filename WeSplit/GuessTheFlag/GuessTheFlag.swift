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
    @State private var scoretitle = ""
    
    var body: some View {
        ZStack {
            
            Color.blue
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundStyle(.white)
                    
                    Text(countries[correctAnswer])
                        .foregroundStyle(.white)
                }
                
                ForEach(0..<3) { number in
                    Button(
                        action: {
                            flagTapped(number)
                        },
                        
                        label: {
                        Image(countries[number])
                    })
                }
            }
        }
        
        .alert(scoretitle, isPresented: $showScore) {
            Button("Continue", action: askQuestion)
        }message: {
            Text("your score is ??")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoretitle = "Correct"
        } else {
            scoretitle = "Wrong"
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
