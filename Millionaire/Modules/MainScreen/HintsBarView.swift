//
//  HintsBarView.swift
//  Millionaire
//
//  Created by Nadia on 22/07/2025.
//

import SwiftUI

struct HintsBarView: View {
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let buttonCount: CGFloat = 4
            let horizontalPadding: CGFloat = 16
            let minSpacing: CGFloat = 12
            let maxSpacing: CGFloat = 32
            let minButtonWidth: CGFloat = 50
            let maxButtonWidth: CGFloat = 100

            // Вычисляем ширину кнопок и расстояние
            let availableWidth = screenWidth - 2 * horizontalPadding - (minSpacing * (buttonCount - 1))
            let proposedButtonWidth = availableWidth / buttonCount
            let buttonWidth = min(max(proposedButtonWidth, minButtonWidth), maxButtonWidth)
            let totalButtonsWidth = buttonWidth * buttonCount
            let remainingSpace = screenWidth - 2 * horizontalPadding - totalButtonsWidth
            let rawSpacing = remainingSpace / (buttonCount - 1)
            let spacing = min(max(rawSpacing, minSpacing), maxSpacing)

            let iconSize = buttonWidth * 0.23
            
            VStack {
                Spacer()
                
                HStack(spacing: spacing) {
                    HintButtonView(iconName: "fifty", iconSize: iconSize, buttonSize: buttonWidth)
                    HintButtonView(iconName: "person.3", iconSize: iconSize, buttonSize: buttonWidth)
                    HintButtonView(iconName: "phone", iconSize: iconSize, buttonSize: buttonWidth)
                    HintButtonView(iconName: "heart", iconSize: iconSize, buttonSize: buttonWidth)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, horizontalPadding)

            }
        }
    }
}

struct HintButtonView: View {
    let iconName: String
    let iconSize: CGFloat
    let buttonSize: CGFloat

    var body: some View {
        ZStack {
            Ellipse()
                .fill(
                    LinearGradient(
                        colors: [Color(hex: "#025D83"), Color(hex: "#022B54"), Color(hex: "#020631"), Color(hex: "#083C66")],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: buttonSize, height: buttonSize * 64 / 84)
                .overlay(
                    Ellipse()
                        .stroke(Color.white, lineWidth: 3)
                )

            if iconName == "fifty" {
                Text("50:50")
                    .foregroundColor(.white)
                    .font(.system(size: iconSize * 0.98, weight: .bold))
            } else {
                Image(systemName: iconName)
                    .font(.system(size: iconSize, weight: .bold))
                    .foregroundColor(.white)
            }
        }
        .frame(width: buttonSize, height: buttonSize * 64 / 84)
    }
}

#Preview {
    HintsBarView()
        .preferredColorScheme(.dark)
}
