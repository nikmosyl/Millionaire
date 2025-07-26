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
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                // MARK: - Timer
                let timer = timerStyle(for: viewModel.timeRemaining)
                
                ZStack {
                    Capsule()
                        .fill(timer.background)
                        .frame(width: 91, height: 45)
                    
                    HStack(spacing: 8) {
                        Image(systemName: "timer")
                            .font(.system(size: 24, weight: .semibold))
                        
                        Text("\(viewModel.timeRemaining)")
                            .font(.system(size: 24, weight: .semibold))
                    }
                    .foregroundColor(timer.font)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                }
                
                // MARK: - Question + Spacer
                VStack() {
                    Text(viewModel.question.title)
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
                        if viewModel.answerStates.count == viewModel.answers.count {
                            ForEach(viewModel.answers.indices, id: \.self) { index in
                                AnswerButtonView(
                                    index: index,
                                    title: viewModel.hiddenAnswerIndices.contains(index) ? "" : viewModel.answers[index],
                                    isDisabled: viewModel.areAnswersDisabled,
                                    state: viewModel.answerStates[index],
                                    onTap: { viewModel.selectAnswer(index) }
                                )
                            }
                        }
                    }
                    
                    // MARK: - Hints
                    HintsBarView(
                        onFiftyFifty: { viewModel.useFiftyFifty() },
                        onAudience: { viewModel.askAudience() },
                        onPhone: { viewModel.callFriend() },
                        onHeart: { viewModel.useExtraLife() },
                        usedHints: viewModel.usedHints
                    )
                }
                .padding(.bottom)
            }
            .padding(.bottom)
            .background(
                LinearGradient(colors: [Color.blue.opacity(0.9), Color.black], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
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
                        Text("QUESTION #\(viewModel.service.gameState.currentLevel)")
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.5))
                        
                        if viewModel.service.gameState.currentLevel > 0,
                           viewModel.service.gameState.currentLevel <= LevelListModel.buttons.count {
                            Text(LevelListModel.buttons[viewModel.service.gameState.currentLevel - 1].dollar)
                                .font(.headline)
                                .foregroundColor(.white)
                        } else {
                            Text("$ ???")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.showLevels = true
                    }) {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.white)
                    }
                }
            }
            .navigationDestination(isPresented: $viewModel.showLevels) {
                LevelListView(selectedButton: viewModel.service.gameState.currentLevel)
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
    let isDisabled: Bool
    let state: AnswerState
    let onTap: () -> Void
    
    var body: some View {
        let style: ColorGradientButton = {
            switch state {
            case .normal:
                return .darkBlue
            case .selected:
                return .yellow
            case .correct:
                return .green
            case .wrong:
                return .red
            }
        }()
        
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
        //.animation(.easeInOut(duration: 0.3), value: isSelected)
        .disabled(isDisabled)
        .padding(.horizontal)
    }
}

// MARK: - Timer Background Helper
private func timerStyle(for seconds: Int) -> (background: Color, font: Color) {
    return switch seconds {
    case 0...3:
        (
            background: Color(hex: "#832203").opacity(0.3),
            font: Color(hex: "#FF6231")
        )
    case 4...12:
        (
            background: Color(hex: "FFA800").opacity(0.5),
            font: Color(hex: "#FFB340")
        )
    default: // 13...30
        (
            background: Color.white.opacity(0.1),
            font: Color.white
        )
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
