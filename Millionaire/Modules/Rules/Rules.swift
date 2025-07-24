//
//  RulesScreen.swift
//  Millionaire
//
//  Created by Rook on 22.07.2025.
//

import SwiftUI

struct Rules: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color("RulesBackground")
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                            
                        Text("Close")
                            .foregroundColor(.blue)
                            .font(.headline)
                            
                        Text("Rules")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.horizontal, 90)
                    }
                }
                .padding(.horizontal)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        rulesSection(title: "Qualifying round", content: """
                        Selection format: 
                        Participants answer a question with four possible answers, placing them in the correct order. 
                        Winner: the one who answered correctly the fastest. 
                        Features: if all participants answer incorrectly, a second round is held.  
                        Cancel button: players can correct their answer.
                        """)
                        
                        rulesSection(title: "Main Game", content: """
                        Main prize: 3 million rubles
                        Number of questions: 15
                        Question format: each question has 4 answer options, only one of which is correct
                        Difficulty: the first 5 questions are easy, 6-10 are medium difficulty, and 11-15 are the most difficult
                        """)
                        
                        rulesSection(title: "Hints", content: """
                        50-50: the computer removes two incorrect answers
                        Calling a friend: you can call and consult for 30 seconds
                        Help from the audience: viewers vote for the correct answer
                        """)
                        
                        rulesSection(title: "Winning System", content: """
                        Non-burnable amount: a certain amount that cannot be lost
                        Stop game: the player can stop the game at any time and collect the money they have earned
                        Using hints: each hint can only be used once
                        """)
                        
                        rulesSection(title: "Additional rules", content: """
                        Participation format: Starting from July 2025, the most knowledgeable and persistent players will enter the game.
                        Final siren: a signal that prompts the player to provide a final answer
                        Rating: we will save the best game result on the main screen
                        Right to error: not available in the current version of the game
                        Question replacement: also not available in the current version
                        """)
                    }
                    .padding(20)
                    .foregroundColor(.white)
                    .font(.system(size: 17, weight: .light, design: .serif))
                }
            }
        }
    }
    
    @ViewBuilder
    private func rulesSection(title: String, content: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title3)
                .bold()
            
            Text(content)
                .padding(.top, 4)
        }
    }
}

#Preview {
    Rules()
        .preferredColorScheme(.dark)
}
