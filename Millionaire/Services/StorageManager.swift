//
//  StorageManager.swift
//  Millionaire
//
//  Created by nikita on 26.07.2025.
//

import Foundation

enum Storage: String{
    case gameState
    case question
}

final class StorageManager {
    static let shared = StorageManager()
    
    private init() {}
    
    func loadGameState() -> GameState {
        if let data = UserDefaults.standard.data(forKey: Storage.gameState.rawValue),
           let gameState = try? JSONDecoder().decode(GameState.self, from: data) {
            return gameState
        }
        
        return GameState()
    }
    
    func saveSettings(_ state: GameState) {
        if let encodedState = try? JSONEncoder().encode(state) {
            UserDefaults.standard.set(encodedState, forKey: Storage.gameState.rawValue)
        }
    }
    
    func loadQuestion() -> Question? {
        if let data = UserDefaults.standard.data(forKey: Storage.question.rawValue),
           let question = try? JSONDecoder().decode(Question.self, from: data) {
            return question
        }
        
        return nil
    }
    
    func saveQuestion(_ question: Question) {
        if let encodedQuestion = try? JSONEncoder().encode(question) {
            UserDefaults.standard.set(encodedQuestion, forKey: Storage.question.rawValue)
        }
    }
}
