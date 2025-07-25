//
//  QuestionModel.swift
//  Millionaire
//
//  Created by Nadia on 22/07/2025.
//

import Foundation

struct QuestionModel: Identifiable {
    let id = UUID()
    let question: String
    let answers: [String] 
    let correctIndex: Int
}
