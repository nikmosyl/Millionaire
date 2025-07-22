//
//  QuestionViewModel.swift
//  
//
//  Created by Nadia on 22/07/2025.
//

import Combine
import Foundation
import SwiftUI

final class QuestionViewModel: ObservableObject {
    @Published var question: QuestionModel
    @Published var timeRemaining = 30
    @Published var selectedAnswer: Int? = nil
    @Published var isAnswerChecked = false

    private var timer: AnyCancellable?
    
    init() {
        self.question = QuestionModel(
            question: "What year was the year, when first deodorant was invented in our life?",
            answers: [
                "First answer option",
                "Second answer option",
                "Third answer option",
                "Fourth answer option"
            ],
            correctIndex: 2
        )
        
        startTimer()

    }
    
    
    func selectAnswer(_ index: Int) {
        selectedAnswer = index
        isAnswerChecked = true
    }
    
    
    // MARK: - Timer
    
    private func startTimer() {
        timer = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }

                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    self.timer?.cancel()
                    self.onTimeOut()
                }
            }
    }

    private func onTimeOut() {
        print("⏱ The End View")
        // coming soon
    }

}


