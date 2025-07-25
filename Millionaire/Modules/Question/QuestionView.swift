//
//  QuestionView.swift
//  Millionaire
//
//  Created by Nadia on 22/07/2025.
//

import SwiftUI

struct QuestionView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = QuestionViewModel()
    @State private var showLevels = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                // MARK: - Timer
                Label {
                    Text("\(viewModel.timeRemaining)")
                        .font(.system(size: 24, weight: .semibold))
                        .multilineTextAlignment(.center)
                } icon: {
                    Image(systemName: "timer")
                        .font(.system(size: 24, weight: .semibold))
                }
                .foregroundColor(.white)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(Color.blue.opacity(0.2))
                .clipShape(Capsule())
                
                // MARK: - Question + Spacer
                VStack() {
                    Text(viewModel.question.question)
                        .font(.system(size: 24))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                    
                    Spacer()
                }
                .frame(height: 147)
                
                // MARK: - Answers + Hints
                VStack(spacing: 40) {
                    
                    // MARK: - Answers
                    VStack(spacing: 16) {
                        ForEach(viewModel.question.answers.indices, id: \.self) { index in
                            AnswerButtonView(
                                index: index,
                                title: viewModel.question.answers[index],
                                isSelected: viewModel.selectedAnswer == index,
                                isDisabled: viewModel.areAnswersDisabled,
                                onTap: { viewModel.selectAnswer(index) }
                            )
                        }
                    }
                    
                    
                    // MARK: - Hints
                    HintsBarView(
                        onFiftyFifty: { viewModel.useFiftyFifty() },
                        onAudience: { viewModel.askAudience() },
                        onPhone: { viewModel.callFriend() },
                        onHeart: { viewModel.useExtraLife() }
                    )
                }
                .padding(.bottom)
                
            }
            .padding(.bottom)
            .background(
                Color(red: 0.07, green: 0.11, blue: 0.25).ignoresSafeArea()
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(
                        action: {
                            dismiss()
                        }) {
                            Image(systemName: "arrow.backward")
                                .foregroundColor(.white)
                        }
                }
                
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
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showLevels = true
                    }) {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.white)
                    }
                }
            }
            .navigationDestination(isPresented: $showLevels) {
                LevelListView(selectedButton: 0)
            }
            .navigationBarBackButtonHidden(true)
            .foregroundColor(.white)
        }
    }
}


// MARK: - AnswerButtonView
struct AnswerButtonView: View {
    let index: Int
    let title: String
    let isSelected: Bool
    let isDisabled: Bool
    let onTap: () -> Void
    
    var body: some View {
        let style: ColorGradientButton = isSelected ? .yellow : .darkBlue
        
        MainButton(style: style, action: onTap) {
            HStack(spacing: 8) {
                Text("\(String(UnicodeScalar(65 + index)!)).")
                    .foregroundColor(Color(hex: "E19B30"))
                    .font(.system(size: 18, weight: .semibold))
                
                Text(title)
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .semibold))
                
                Spacer()
            }
            .frame(height: 36)
            .padding(.top, 16)
            .padding(.bottom, 19)
            .padding(.leading, 34)
            .padding(.trailing, 24)
        }
        .animation(.easeInOut(duration: 0.3), value: isSelected)
        .disabled(isDisabled)
        .padding(.horizontal)
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
