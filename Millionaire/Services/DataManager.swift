//
//  DataManager.swift
//  Millionaire
//
//  Created by nikita on 23.07.2025.
//

import Foundation

final class DataManager {
    static let shared = DataManager()
    
    private let apiUrl = "https://opentdb.com/api.php?amount=1&type=multiple&difficulty="
    
    private init() {}
    
    func getApiData(difficulty: DifficultyLevel, completion: @escaping (ApiResponseEvent) -> Void) {
        let url = apiUrl + difficulty.rawValue
        NetworkManager.shared.fetch(ApiResponseEvent.self, from: url) { result in
            switch result {
            case .success(let apiResponse):
                completion(apiResponse)
            case .failure:
                completion(ApiResponseEvent(responseCode: -1, results: []))
            }
        }
    }
    
    func getQuestion(difficulty: DifficultyLevel, completion: @escaping (Question) -> Void) {
        func fetchApi() {
            getApiData(difficulty: difficulty) { apiResponse in
                if apiResponse.responseCode == 0, let question = apiResponse.results.first {
                    completion(question)
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        fetchApi()
                    }
                }
            }
        }
        
        fetchApi()
    }
}

