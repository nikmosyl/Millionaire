//
//  LevelListView.swift
//  Millionaire
//
//  Created by DimaTru on 23.07.2025.
//

import SwiftUI

struct LevelListView: View {
    let buttons = LevelListModel.buttons
    let selectedButton: Int
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Image(.logo)
                    .resizable()
                    .frame(width: 85, height: 85)
                    .zIndex(1)
                    .offset(y: 15)
                    .shadow(color: Color.black.opacity(0.5), radius: 44, x: 0, y: 0)
                ForEach(Array(buttons.enumerated().reversed()), id: \.1.id) { index, button in
                    MainButton(style: index + 1 == selectedButton ? ColorGradientButton.green : button.color, action: { }) {
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
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        // action
                    }) {
                        Image(.withdrawal)
                    }
                }
            }
        }
    }
}

#Preview {
    LevelListView(selectedButton: 7)
}
