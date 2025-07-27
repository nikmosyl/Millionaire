//
//  LevelListView.swift
//  Millionaire
//
//  Created by DimaTru on 23.07.2025.
//

import SwiftUI

struct LevelListView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var navigateToQuestion: Bool
    @Binding var showGameOverAlert: Bool
    @State private var showAlert = false
    @State private var showWinAlert = false
    
    let buttons = LevelListModel.buttons
    let selectedButton: Int
    
    var body: some View {
        VStack(spacing: 0) {
            Image(.logo)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 85, height: 85)
                .zIndex(1)
                .offset(y: 15)
                .shadow(color: Color.black.opacity(0.5), radius: 44, x: 0, y: 0)
            ForEach(Array(buttons.enumerated().reversed()), id: \.1.id) { index, button in
                MainButton(
                    style: index + 1 == selectedButton ? ColorGradientButton.green : button.color,
                    action: {
                    }) {
                        HStack {
                            Text(button.number)
                            Spacer()
                            Text(button.dollar)
                        }
                        .frame(maxHeight: .infinity)
                        .foregroundStyle(.white)
                        .font(.system(size: 18, weight: .bold))
                        .padding(.horizontal, 24)
                    }
                    .disabled(true)
            }
        }
        .padding(.horizontal, 32)
        .background(
            LinearGradient(colors: [Color.blue.opacity(0.9), Color.black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        )
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(
                    action: {
                        print("selectedButton:", selectedButton)
                        if selectedButton <= 0 || selectedButton > 14 {
                            navigateToQuestion = false
                        } else {
                            dismiss()
                        }
                    }) {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(.white)
                    }
            }
            
            ToolbarItem {
                Button(action: {
                    GameService.shared.gameState.bestScore = LevelList.levels[selectedButton] ?? ""
                    GameService.shared.saveState()
                    showWinAlert = true
                }) {
                    Image(.withdrawal)
                }
            }
        }
        .onAppear {
            if showGameOverAlert {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    showAlert = true
                }
            }
        }
        .alert("Game Over", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Yor won \(LevelList.levels[GameService.shared.saveLevel] ?? "$ 0")")
        }
        .alert("Game Over", isPresented: $showWinAlert) {
            Button("OK", role: .cancel) {
                navigateToQuestion = true
            }
        } message: {
            Text("Yor won \(LevelList.levels[GameService.shared.gameState.currentLevel - 1] ?? "$ 0")")
        }
        
    }
}

#Preview {
    LevelListView(navigateToQuestion: .constant(false), showGameOverAlert: .constant(false), selectedButton: 1, )
}
