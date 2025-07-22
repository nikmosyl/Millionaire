//
//  HomeViewModel.swift
//  Millionaire
//
//  Created by Aleksandr Zhazhoyan on 22.07.2025.
//

import Foundation
import SwiftUI


class HomeViewModel: ObservableObject {
    
    @Published var gameState: GameState
    
    init() {
        self.gameState = GameState(bestScore: 15000, continueGame: true)
    }
    
    
    func startNewGame() {
        gameState.continueGame = false
        print("New game started")
    }
    
    func continGame() {
        print("Continuing existing game")
    }
    
    
}
