//
//  TestView.swift
//  Millionaire
//
//  Created by nikita on 21.07.2025.
//

import SwiftUI

struct TestView: View {
    @StateObject private var viewModel = TestViewModel()
    
    var body: some View {
        VStack {
            Text( "\(viewModel.counter)" )
            
            Button("increment") {
                viewModel.increment()
            }
        }
    }
}

#Preview {
    TestView()
}
