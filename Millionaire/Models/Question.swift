//
//  Question.swift
//  Millionaire
//
//  Created by nikita on 23.07.2025.
//

struct ApiResponseEvent: Decodable {
    let responseCode: Int
    let results: [Question]
    
    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case results = "results"
    }
}

struct Question: Decodable {
    let difficulty: String
    let title: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    
    enum CodingKeys: String, CodingKey {
        case difficulty = "difficulty"
        case title = "question"
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}
