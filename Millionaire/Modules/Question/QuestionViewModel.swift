//
//  QuestionViewModel.swift
//
//
//  Created by Nadia on 22/07/2025.
//

import Combine
import Foundation
import SwiftUI

enum AnswerState {
    case normal
    case selected
    case correct
    case wrong
}

final class QuestionViewModel: ObservableObject {
    @Published var question: Question
    @Published var timeRemaining = 30
    @Published var selectedAnswer: Int?
    @Published var isAnswerCorrect: Bool?
    @Published var isAnswerChecked = false
    @Published var areAnswersDisabled = false
    @Published var showLevels = false
    
    @Published var answers: [String] = []
    @Published var answerStates: [AnswerState] = []
    
    @Published var hiddenAnswerIndices: Set<Int> = []
    @Published var isFiftyUsed = false
    @Published var usedHints: Set<HintType> = []
    
    let service = GameService.shared
    
    private var timer: AnyCancellable?
    
    init() {
        if let currentQuestion = service.currentQuestion {
            question = currentQuestion
            shuffleAnswers()
        } else {
            question = Question(
                difficulty: "",
                title: "A question will appear here soon",
                correctAnswer: "",
                incorrectAnswers: []
            )
            service.getQuestion { [weak self] question in
                DispatchQueue.main.async {
                    self?.question = question
                    self?.shuffleAnswers()
                }
            }
        }
        
        startTimer()
    }
    
    func shuffleAnswers() {
        answers = ([question.correctAnswer] + question.incorrectAnswers).shuffled()
        answerStates = Array(repeating: .normal, count: answers.count)
    }
    
    func selectAnswer(_ index: Int) {
        guard !areAnswersDisabled else { return }
        areAnswersDisabled = true
        selectedAnswer = index
        answerStates[index] = .selected
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.checkAnswer()
        }
    }
    
    private func checkAnswer() {
        guard let selected = selectedAnswer else { return }
        
        let correctIndex = answers.firstIndex(of: question.correctAnswer)
        
        if selected == correctIndex {
            answerStates[selected] = .correct
            
        } else {
            answerStates[selected] = .wrong
            if let correct = correctIndex {
                answerStates[correct] = .correct
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showLevels = true
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
        guard !usedHints.contains(.fiftyFifty) else { return }
        usedHints.insert(.fiftyFifty)
        print("👉 50:50 hint used")

        let incorrectIndices = answers.indices.filter {
            answers[$0] != question.correctAnswer
        }
        
        hiddenAnswerIndices = Set(incorrectIndices.shuffled().prefix(2))
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


