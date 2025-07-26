//
//  GameService.swift
//  Millionaire
//
//  Created by nikita on 26.07.2025.
//

import Foundation

final class GameService {
    static let shared = GameService()
    
    private let storage = StorageManager.shared
    private var currentDifficulty: DifficultyLevel
    
    private(set) var currentQuestion: Question?
    private(set) var gameState: GameState
    
    private init() {
        currentQuestion = storage.loadQuestion()
        gameState = storage.loadGameState()
        currentDifficulty = switch gameState.currentLevel {
        case 0...5:
                .easy
        case 6...10:
                .medium
        default:
                .hard
        }
        
        print("currLeve:", gameState.currentLevel)
    }
    
    func getCurrentDifficulty() -> DifficultyLevel {
        switch gameState.currentLevel {
        case 0...5:
                .easy
        case 6...10:
                .medium
        default:
                .hard
        }
    }
    
    func getQuestion(completion: @escaping (Question) -> Void) {
        DataManager.shared.getQuestion(difficulty: currentDifficulty) { question in
            completion(question)
        }
    }
    
    func newGame() {
        gameState.currentLevel = 1
    }
}
