//
//  GameState.swift
//  Millionaire
//
//  Created by Aleksandr Zhazhoyan on 22.07.2025.
//

struct GameState: Codable {
    var bestScore: String = ""
    var currentLevel: Int = 0
    var timeRemaining: Int = 30
    var usedHints: Set<HintType> = []
}
