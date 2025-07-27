//
//  Question.swift
//  Millionaire
//
//  Created by nikita on 23.07.2025.
//

import Foundation

struct ApiResponseEvent: Decodable {
    let responseCode: Int
    let results: [Question]
    
    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case results = "results"
    }
}

struct Question: Codable {
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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Декодируем строки с HTML-сущностями
        let rawTitle = try container.decode(String.self, forKey: .title)
        let rawCorrectAnswer = try container.decode(String.self, forKey: .correctAnswer)
        let rawIncorrectAnswers = try container.decode([String].self, forKey: .incorrectAnswers)
        let rawDifficulty = try container.decode(String.self, forKey: .difficulty)
        
        // Декодируем HTML-сущности
        self.title = decodeHTMLEntities(rawTitle)
        self.correctAnswer = decodeHTMLEntities(rawCorrectAnswer)
        self.incorrectAnswers = rawIncorrectAnswers.map { decodeHTMLEntities($0) }
        self.difficulty = decodeHTMLEntities(rawDifficulty)
    }
    
    init(difficulty: String, title: String, correctAnswer: String, incorrectAnswers: [String]) {
        self.difficulty = title
        self.title = title
        self.correctAnswer = correctAnswer
        self.incorrectAnswers = incorrectAnswers
    }
}

func decodeHTMLEntities(_ string: String) -> String {
    guard let data = string.data(using: .utf8) else { return string }
    let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
        .documentType: NSAttributedString.DocumentType.html,
        .characterEncoding: String.Encoding.utf8.rawValue
    ]

    if let attributed = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
        return attributed.string
    } else {
        return string
    }
}
