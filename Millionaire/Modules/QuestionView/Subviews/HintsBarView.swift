//
//  HintsBarView.swift
//  Millionaire
//
//  Created by Nadia on 22/07/2025.
//

import SwiftUI


enum HintType: String, CaseIterable {
    case fiftyFifty = "50:50"
    case audience = "person.3"
    case phone = "phone"
    case heart = "heart"
}

struct HintsBarView: View {
    var onFiftyFifty: () -> Void = {}
    var onAudience: () -> Void = {}
    var onPhone: () -> Void = {}
    var onHeart: () -> Void = {}
    
    var onHintTapped: (HintType) -> Void = { _ in }
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let buttonCount: CGFloat = 4
            let horizontalPadding: CGFloat = 16
            let minSpacing: CGFloat = 12
            let maxSpacing: CGFloat = 32
            let minButtonWidth: CGFloat = 50
            let maxButtonWidth: CGFloat = 100
            
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
                    ForEach(HintType.allCases, id: \.self) { hint in
                        HintButton(action: {
                           switch hint {
                           case .fiftyFifty: onFiftyFifty()
                           case .audience:   onAudience()
                           case .phone:      onPhone()
                           case .heart:      onHeart()
                           }
                        }) {
                            ZStack {
                                if hint == .fiftyFifty {
                                    Text(hint.rawValue)
                                        .foregroundColor(.white)
                                        .font(.system(size: iconSize * 0.98, weight: .bold))
                                } else {
                                    Image(systemName: hint.rawValue)
                                        .font(.system(size: iconSize, weight: .bold))
                                        .foregroundColor(.white)
                                }
                            }
                            .frame(width: buttonWidth, height: buttonWidth * 64 / 84)
                        }
                        .frame(width: buttonWidth, height: buttonWidth * 64 / 84)
                    }
                }
                .padding(.horizontal, horizontalPadding)
            }
        }
    }
}


struct HintButton<Content: View>: View {
    let action: () -> Void
    let content: Content
    @State private var isPressed = false

    init(
        action: @escaping () -> Void,
        @ViewBuilder content: () -> Content
    ) {
        self.action = action
        self.content = content()
    }

    var body: some View {
        Button(action: action) {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Ellipse()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(hex: "#025D83"),
                                    Color(hex: "#022B54"),
                                    Color(hex: "#020631"),
                                    Color(hex: "#083C66")
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                )
                .overlay(
                    Ellipse()
                        .stroke(Color.white, lineWidth: 3)
                )
                .scaleEffect(isPressed ? 0.94 : 1.0)
                .animation(.easeInOut(duration: 0.15), value: isPressed)
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
        .buttonStyle(.plain)
    }
}


#Preview {
    HintsBarView(
        onFiftyFifty: { print("50:50 tapped") },
        onAudience: { print("Audience tapped") },
        onPhone: { print("Phone tapped") },
        onHeart: { print("Heart tapped") }
    )
    .preferredColorScheme(.dark)
}
