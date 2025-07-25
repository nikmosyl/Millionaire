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
        self.gameState = GameState(bestScore: 15000, continueGame: false)
    }
    
    func startNewGame() {
        #warning("DEBUG:")
        print("Нажата кнопка новой игры")
        
        #warning("TO DO: реализовать функционал начала новой игры")
    }
    
    func continueGame() {
        #warning("DEBUG:")
        print("Нажата кнопка продолжения игры")

        #warning("TO DO: реализовать функционал начала новой игры")
    }
}
