//
//  GameOverViewModel.swift
//  Millionaire
//
//  Created by Aleksandr Zhazhoyan on 24.07.2025.
//

import Foundation

class GameOverViewModel: ObservableObject{
    @Published var result: GameResult
    
    init() {
        self.result = GameResult(level: 1, score: 10000)
    }
    
    var levelText: String {
        "Level \(result.level)"
    }
    
    var scoreText: String {
        "$\(result.score)"
    }
    
    func startNewGame() {
        print("Start new game")
    }
    
    func mainScreen() {
        print("Main screen")
    }
}
