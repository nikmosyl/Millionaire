//
//  TestViewModel.swift
//  Millionaire
//
//  Created by nikita on 21.07.2025.
//

import Foundation

final class TestViewModel: ObservableObject {
    @Published var counter = 0
    
    func increment() {
        counter += 1
    }
}
