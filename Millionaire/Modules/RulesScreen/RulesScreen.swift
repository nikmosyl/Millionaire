//
//  RulesScreen.swift
//  Millionaire
//
//  Created by Rook on 22.07.2025.
//

import SwiftUI

struct RulesScreen: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color("RulesBackground").ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true), label: {
                            
                            Image(systemName: "chevron.left")
                                .padding(.leading)
                                .font(.subheadline)
                            
                            Text("Back")
                                .foregroundColor(.blue)
                                .font(.headline)
                                .multilineTextAlignment(.leading)
                            
                            VStack {
                                Text("Rules")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 90)
                            }
                        })
                    }
                    
                    VStack(alignment:.center, spacing: 20) {
                        ScrollView(showsIndicators: false){
                            Section(
                                header: Text("Qualifying round")
                                    .font(.title3)
                                    .bold()
                                , content: {
                                    Text("""
                                    
                                    Selection format: 
                                    Participants answer a question with four possible answers, placing them in the correct order. 
                                    Winner: the one who answered correctly the fastest. 
                                    Features: if all participants answer incorrectly, a second round is held.  
                                    Cancel button: players can correct their answer.
                                    
                                    """)
                                })
                            
                            Spacer()
                            
                            Section(
                                header: Text("Main Game")
                                    .font(.title3)
                                    .bold()
                                , content: {
                                    Text("""
                                    
                                    Main prize: 3 million rubles
                                    Number of questions: 15
                                    Question format: each question has 4 answer options, only one of which is correct
                                    Difficulty: the first 5 questions are easy, 6-10 are medium difficulty, and 11-15 are the most difficult
                                    
                                    """)
                                })
                            
                            Spacer()
                            Section(
                                header: Text("Hints")
                                    .font(.title3)
                                    .bold()
                                , content: {
                                    Text("""
                                    
                                    50-50: the computer removes two incorrect answers
                                    Calling a friend: you can call and consult for 30 seconds
                                    Help from the audience: viewers vote for the correct answer
                                    
                                    """)
                                })
                            
                            Spacer()
                            
                            Section(
                                header: Text("Winning System")
                                    .font(.title3)
                                    .bold()
                                , content: {
                                    Text("""
                                    
                                    Non-burnable amount: a certain amount that cannot be lost
                                    Stop game: the player can stop the game at any time and collect the money they have earned
                                    Using hints: each hint can only be used once
                                    
                                    """)
                                })
                            
                            Spacer()
                            
                            Section(
                                header: Text("Additional rules")
                                    .font(.title3)
                                    .bold()
                                , content: {
                                    Text("""
                                    
                                    Participation format: Starting from July 2025, the most knowledgeable and persistent players will enter the game.
                                    Final siren: a signal that prompts the player to provide a final answer
                                    Rating: we will save the best game result on the main screen
                                    Right to error: not available in the current version of the game
                                    Question replacement: also not available in the current version
                                    """)
                                })
                        }.foregroundColor(.white)
                            .font(.system(size: 17, weight: .light, design: .serif))
                        
                            .padding(20)
                    }
                    
                }
                
                Spacer()
            }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RulesScreen()
}
