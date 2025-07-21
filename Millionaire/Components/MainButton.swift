//
//  MainButton.swift
//  Millionaire
//
//  Created by DimaTru on 21.07.2025.
//

import SwiftUI

struct MainButton: View {
    var title: String
    var action: () -> Void
    
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 22, weight: .bold))
                .padding()
                .background(
                    ArrowShapeButton()
                        .fill(
                            LinearGradient(colors: [Color.yellow.opacity(0.6), Color.orange.opacity(0.8), Color.yellow.opacity(0.6)], startPoint: .top, endPoint: .bottom)
                        )
                )
                .overlay(
                    ArrowShapeButton()
                        .stroke(Color.gray.opacity(0.4), lineWidth: 3)
                )
                
        }
    }
}

struct ArrowShapeButton: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let inset: CGFloat = rect.height * 0.3
        
        path.move(to: CGPoint(x: inset, y: 0))
        path.addLine(to: CGPoint(x: rect.width - inset, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height / 2))
        path.addLine(to: CGPoint(x: rect.width - inset, y: rect.height))
        path.addLine(to: CGPoint(x: inset, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height / 2))
        path.closeSubpath()
        
        return path
    }
}


#Preview {
    MainButton(title: "title", action: {})
}


// через ViewBilder сздать динамический компонент
