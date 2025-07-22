//
//  QuestionView.swift
//  Millionaire
//
//  Created by Nadia on 22/07/2025.
//

import SwiftUI

struct QuestionView: View {
    @StateObject private var viewModel = QuestionViewModel()
    
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(spacing: 30) {
                    // Timer
                    Text("⏱ \(viewModel.timeRemaining)")
                        .font(.title)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 16)
                        .background(Color.blue.opacity(0.2))
                        .clipShape(Capsule())
                    
                    
                    // Question
                    Text(viewModel.question.question)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                
                Spacer()
                
                // Answers
                VStack(spacing: 16) {
                    ForEach(viewModel.question.answers.indices, id: \.self) { index in
                        Button(action: {
                            viewModel.selectAnswer(index)
                        }) {
                            HStack(spacing: 8) {
                                Text("\(String(UnicodeScalar(65 + index)!)).")
                                    .foregroundColor(Color(hex: "E19B30"))
                                    .font(.system(size: 18, weight: .semibold))

                                Text(viewModel.question.answers[index])
                                    .foregroundColor(.white)
                                    .font(.system(size: 18, weight: .semibold))

                                Spacer()
                                
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(viewModel.isAnswerChecked && index == viewModel.question.correctIndex
                                          ? Color.green // Temporary Color
                                          : Color.clear
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.white, lineWidth: 3)
                                    )
                            )
                            
                        }
                        .padding(.horizontal)
                    }
                }
                
                Spacer()
                
                // Lifelines
                HStack(spacing: 24) {
                    Circle().overlay(Text("50:50").font(.footnote))
                        .frame(width: 48, height: 48)
                    Circle().overlay(Image(systemName: "person.3"))
                        .frame(width: 48, height: 48)
                    Circle().overlay(Image(systemName: "phone"))
                        .frame(width: 48, height: 48)
                }
                .foregroundColor(.white.opacity(0.9))
                .padding(.bottom)
            }
            .padding()
            .toolbar {
                // Back
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // TODO: Add navigation back logic
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                    }
                }
                
                // Title
                ToolbarItem(placement: .principal) {
                    VStack(spacing: 2) {
                        Text("QUESTION #1")
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.5))
                        Text("$500")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                }
                
                // Settings
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // TODO: Open settings
                    }) {
                        Image(systemName: "gearshape")
                            .foregroundColor(.white)
                    }
                }
            }
            
            .navigationBarBackButtonHidden(true)
            .background(Color(red: 0.07, green: 0.11, blue: 0.25).ignoresSafeArea())
            .foregroundColor(.white)
            
        }
    }
}


// MARK: - Color+Hex

extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }
}


#Preview {
    QuestionView()
}
