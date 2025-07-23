//
//  TestViewModel.swift
//  Millionaire
//
//  Created by nikita on 21.07.2025.
//

import Foundation

final class TestViewModel: ObservableObject {
    @Published var counter = 0
    @Published var question: Question?
    
    func getQuestion(difficlulty: DifficultyLevel) {
        DataManager.shared.getQuestion(difficulty: difficlulty) { question in
            DispatchQueue.main.async {
                self.question = question
            }
        }
    }
    
    func increment() {
        counter += 1
    }
}
