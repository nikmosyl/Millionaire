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
            
            HStack {
                Button("easy") {
                    viewModel.getQuestion(difficlulty: .easy)
                }
                
                Button("medium") {
                    viewModel.getQuestion(difficlulty: .medium)
                }
                
                Button("hard") {
                    viewModel.getQuestion(difficlulty: .hard)
                }
            }
            
            Text("\(viewModel.question?.title ?? "question")")
                .font(.largeTitle)
            Text("\(viewModel.question?.correctAnswer ?? "answer    ")")
            
            if let question = viewModel.question {
                ForEach(question.incorrectAnswers, id: \.self) { answer in
                    Text(answer)
                }
            }
        }
    }
}

#Preview {
    TestView()
}
