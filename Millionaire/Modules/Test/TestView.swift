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
            MainButton(style: viewModel.counter % 2 == 0 ? .darkBlue : .green) {
                viewModel.increment()
            } content: {
                Text("\(viewModel.counter)")
                    .frame(height:50)
            }
            .padding()
        }
    }
}

#Preview {
    TestView()
}
