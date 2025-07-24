//
//  HomeViewModel.swift
//  Millionaire
//
//  Created by Aleksandr Zhazhoyan on 22.07.2025.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var gameState: GameState
    
    init() {
        self.gameState = GameState(bestScore: 15000, continueGame: true, newGame: false)
    }
    
    func startNewGame() {
        gameState = GameState(
                bestScore: gameState.bestScore,
                continueGame: true,
                newGame: true
            )
        print("New game started")
    }
    
    func continGame() {
        print("Continuing existing game")
    }
}
