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
    
    private lazy var currentDifficulty: DifficultyLevel = {
        switch gameState.currentLevel {
        case 0...5:
                .easy
        case 6...10:
                .medium
        default:
                .hard
        }
    }()
    
    private(set) var currentQuestion: Question?
    
    var gameState: GameState
    
    var saveLevel: Int = 0
    
    private init() {
        currentQuestion = storage.loadQuestion()
        gameState = storage.loadGameState()
    }
    
    func getQuestion(completion: @escaping (Question) -> Void) {
        DataManager.shared.getQuestion(difficulty: currentDifficulty) { question in
            completion(question)
        }
    }
    
    func newGame() {
        gameState.currentLevel = 1
        gameState.timeRemaining = 30
    }
    
    func winRaund() {
        if gameState.currentLevel < LevelList.maxLevel {
            if LevelList.saves.contains(gameState.currentLevel) {
                saveLevel = gameState.currentLevel
            }
            
            gameState.currentLevel += 1
            gameState.timeRemaining = 30
        }
        else {
            print("YOU ARE MILLIONERE")
        }
    }
    
    func loseRaund() {
        gameState.timeRemaining = 30
        _ = endGame()
    }
    
    
    func endGame() -> Int {
        gameState.currentLevel = 0
        return saveLevel
    }
}
