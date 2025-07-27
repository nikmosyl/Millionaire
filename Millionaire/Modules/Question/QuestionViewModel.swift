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
    
    @Published var showLevels = false
    @Published var showGameOverAlert = false
    
    @Published var showAudienceAlert = false
    @Published var audienceHintText: String = ""
    
    @Published var showPhoneAlert = false
    @Published var phoneHintText: String = ""
    
    @Published var selectedAnswer: Int?
    @Published var isAnswerCorrect: Bool?
    @Published var isAnswerChecked = false
    @Published var areAnswersDisabled = false
    
    @Published var answers: [String] = []
    @Published var answerStates: [AnswerState] = []
    @Published var disabledAnswerIndexes: Set<Int> = []
    
    @Published var usedHints: Set<HintType> {
        didSet {
            service.gameState.usedHints = usedHints
            service.saveState()
        }
    }
    
    @Published var timeRemaining = GameService.shared.gameState.timeRemaining
    private var isPaused = false
    
    let service = GameService.shared
    
    private var timer: AnyCancellable?
    
    init() {
        usedHints = service.gameState.usedHints
        
        if let currentQuestion = service.currentQuestion {
            print("currentQuestion", currentQuestion)
            question = currentQuestion
            shuffleAnswers()
        } else {
            question = Question(
                difficulty: "",
                title: "A question will appear here soon",
                correctAnswer: "",
                incorrectAnswers: []
            )
            self.pauseTimer()
            service.getQuestion { [weak self] question in
                DispatchQueue.main.async {
                    self?.question = question
                    self?.shuffleAnswers()
                    self?.startTimer()
                }
            }
        }
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
        
        pauseTimer()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.checkAnswer()
        }
    }
    
    private func checkAnswer() {
        guard let selected = selectedAnswer else { return }
        
        let correctIndex = answers.firstIndex(of: question.correctAnswer)
        
        if selected == correctIndex {
            answerStates[selected] = .correct
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.showLevels = true
                self.service.winRaund()
            }
        } else {
            answerStates[selected] = .wrong
            if let correct = correctIndex {
                answerStates[correct] = .correct
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.showLevels = true
                self.showGameOverAlert = true
                self.service.loseRaund()
            }
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
        
        print("👉 50:50 hint used")
        usedHints.insert(.fiftyFifty)

        guard let correctIndex = answers.firstIndex(of: question.correctAnswer) else { return }

        let incorrectIndexes = answers.indices.filter { $0 != correctIndex }
        let toDisable = incorrectIndexes.shuffled().prefix(2)

        disabledAnswerIndexes = Set(toDisable)

        for index in toDisable {
            answers[index] = ""
            answerStates[index] = .normal
        }
    }
    
    func askAudience() {
        guard !usedHints.contains(.audience) else { return }

        print("🧑‍🤝‍🧑 Audience hint used")
        usedHints.insert(.audience)

        // 80% шанс на правильный ответ
        let isCorrect = Bool.random(probability: 0.7)

        let suggestion: String
        if isCorrect {
            suggestion = question.correctAnswer
        } else {
            suggestion = question.incorrectAnswers.randomElement() ?? "🤷‍♂️"
        }

        audienceHintText = "The audience thinks that the correct answer is: \"\(suggestion)\""
        showAudienceAlert = true
    }
    
    func callFriend() {
        guard !usedHints.contains(.phone) else { return }

        print("📞 Phone a friend used")
        usedHints.insert(.phone)

        // 70% шанс на правильный ответ
        let isCorrect = Bool.random(probability: 0.8)

        let suggestion: String
        if isCorrect {
            suggestion = question.correctAnswer
        } else {
            suggestion = question.incorrectAnswers.randomElement() ?? "🤷‍♂️"
        }

        phoneHintText = "A friend thinks that the correct answer is: \"\(suggestion)\""
        showPhoneAlert = true
    }
    
    func useExtraLife() {
        print("❤️ Extra life used")
        // TODO: implement logic
    }
    
    // MARK: - Timer
    
    func startTimer() {
        timer = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                    self.service.gameState.timeRemaining = self.timeRemaining
                } else {
                    self.timer?.cancel()
                    self.onTimeOut()
                }
            }
    }
    
    func pauseTimer() {
        timer?.cancel()
        timer = nil
    }
    
    private func onTimeOut() {
        showLevels = true
        service.loseRaund()
    }
    
    func onAppear() {
        timeRemaining = service.gameState.timeRemaining
        areAnswersDisabled = false
        disabledAnswerIndexes = []
        
        if service.gameState.timeRemaining == 30 {
            question = Question(
                difficulty: "",
                title: "A question will appear here soon",
                correctAnswer: "",
                incorrectAnswers: []
            )
            self.pauseTimer()
            service.getQuestion { [weak self] question in
                DispatchQueue.main.async {
                    self?.question = question
                    self?.shuffleAnswers()
                    self?.startTimer()
                }
            }
        }
    }
}

extension Bool {
    /// Возвращает true с заданной вероятностью (0.0...1.0)
    static func random(probability: Double) -> Bool {
        return Double.random(in: 0...1) < probability
    }
}
