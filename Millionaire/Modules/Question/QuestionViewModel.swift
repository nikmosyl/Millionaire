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
    @Published var selectedAnswer: Int?
    @Published var isAnswerCorrect: Bool?
    @Published var isAnswerChecked = false
    @Published var areAnswersDisabled = false
    
    private var timer: AnyCancellable?
    
    init() {
        self.question = QuestionModel(
            question: """
            What year was the year, when first deodorant was invented in our life?
            """,
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
        guard !areAnswersDisabled else { return }
        
        selectedAnswer = index
        areAnswersDisabled = true
        isAnswerChecked = true
        
        // Checking answer
        isAnswerCorrect = (index == question.correctIndex)
        
        // Reset answer
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
            self.resetAnswerState()
        }
    }
    
    private func resetAnswerState() {
        selectedAnswer = nil
        isAnswerChecked = false
        isAnswerCorrect = nil
        areAnswersDisabled = false
    }
    
    // MARK: - Hints
    func useFiftyFifty() {
        print("👉 50:50 hint used")
        // TODO: implement logic
    }
    
    func askAudience() {
        print("🧑‍🤝‍🧑 Audience hint used")
        // TODO: implement logic
    }
    
    func callFriend() {
        print("📞 Phone a friend used")
        // TODO: implement logic
    }
    
    func useExtraLife() {
        print("❤️ Extra life used")
        // TODO: implement logic
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


