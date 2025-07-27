//
//  HomeViewModel.swift
//  Millionaire
//
//  Created by Aleksandr Zhazhoyan on 22.07.2025.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var gameState: GameState = GameService.shared.gameState
    
    func onAppear() {
        gameState = GameService.shared.gameState
    }
    
    func startNewGame() {
        GameService.shared.newGame()
        gameState = GameService.shared.gameState
    }
    
    func continueGame() {
        gameState = GameService.shared.gameState
    }
}
