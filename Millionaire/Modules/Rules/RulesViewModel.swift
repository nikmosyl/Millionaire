//
//  RulesViewModel.swift
//  Millionaire
//
//  Created by Rook on 24.07.2025.
//
import Foundation
class RulesViewModel: ObservableObject {
    @Published var rulesSections: [RulesSection] = [
        RulesSection(
            id: UUID(),
            title: "Qualifying round",
            content: """
            Selection format: 
            Participants answer a question with four possible answers, placing them in the correct order. 
            Winner: the one who answered correctly the fastest. 
            Features: if all participants answer incorrectly, a second round is held.  
            Cancel button: players can correct their answer.
            """
        ),
        
        RulesSection(
            id: UUID(),
            title: "Main Game",
            content: """
            Main prize: 3 million rubles
            Number of questions: 15
            Question format: each question has 4 answer options, only one of which is correct
            Difficulty: the first 5 questions are easy, 6-10 are medium difficulty, and 11-15 are the most difficult
            """
        ),
        
        RulesSection(
            id: UUID(),
            title: "Hints",
            content: """
            50-50: the computer removes two incorrect answers
            Calling a friend: you can call and consult for 30 seconds
            Help from the audience: viewers vote for the correct answer
            """
        ),
        
        RulesSection(
            id: UUID(),
            title: "Winning System",
            content: """
            Non-burnable amount: a certain amount that cannot be lost
            Stop game: the player can stop the game at any time and collect the money they have earned
            Using hints: each hint can only be used once
            """
        ),
        
        RulesSection(
            id: UUID(),
            title: "Additional rules",
            content: """
            Participation format: Starting from July 2025, the most knowledgeable and persistent players will enter the game.
            Final siren: a signal that prompts the player to provide a final answer
            Rating: we will save the best game result on the main screen
            Right to error: not available in the current version of the game
            Question replacement: also not available in the current version
            """
        )
    ]
    
    struct RulesSection: Identifiable {
        let id: UUID
        let title: String
        let content: String
    }
}
