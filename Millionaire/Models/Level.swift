//
//  Level.swift
//  Millionaire
//
//  Created by nikita on 26.07.2025.
//

import Foundation

enum LevelType {
    case normal
    case save
    case win
}

struct LevelList {
    static let maxLevel = 15
    
    static let saves: Set<Int> = [5, 10]
    
    static let levels: [Int: String] = [
        1 : "$ 500",
        2 : "$ 1,000",
        3 : "$ 2,000",
        4 : "$ 3,000",
        5 : "$ 5,000",
        6 : "$ 7,500",
        7 : "$ 10,000",
        8 : "$ 12,500",
        9 : "$ 15,000",
        10 : "$ 25,500",
        11 : "$ 50,000",
        12 : "$ 100,000",
        13 : "$ 250,000",
        14 : "$ 500,000",
        15 : "$ 1,000,000"
    ]
}
