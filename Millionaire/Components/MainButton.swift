//
//  MainButton.swift
//  Millionaire
//
//  Created by DimaTru on 21.07.2025.
//

import SwiftUI

struct MainButton<Content: View>: View {
    let action: () -> Void
    let content: Content
    let style: ColorGradientButton
    
    init( style: ColorGradientButton = .darkBlue,
          action: @escaping () -> Void,
          @ViewBuilder content: () -> Content)
    {
        self.action = action
        self.content = content()
        self.style = style
    }
    
    var body: some View {
        Button(action: action) {
            content
                .frame(maxWidth: .infinity)
                .background(
                    ArrowShapeButton()
                        .fill(style.gradient)
                )
                .overlay(
                    ArrowShapeButton()
                        .stroke(Color.white, lineWidth: 3)
                )
        }
    }
}

struct ArrowShapeButton: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        func point(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
            return CGPoint(x: x * rect.width, y: y * rect.height)
        }
        
        path.move(to: point(0.8818, 0.022))
        
        path.addCurve(to: point(0.9352, 0.1454),
                      control1: point(0.9028, 0.022),
                      control2: point(0.9223, 0.0676))
        
        path.addLine(to: point(0.9914, 0.4865))
        path.addLine(to: point(0.9936, 0.5))
        path.addLine(to: point(0.9914, 0.5135))
        
        path.addLine(to: point(0.9352, 0.8546))
        
        path.addCurve(to: point(0.8818, 0.9779),
                      control1: point(0.9223, 0.9324),
                      control2: point(0.9028, 0.978))
        
        path.addLine(to: point(0.1182, 0.978))
        
        path.addCurve(to: point(0.0648, 0.8546),
                      control1: point(0.0972, 0.978),
                      control2: point(0.0777, 0.9324))
        
        path.addLine(to: point(0.0086, 0.5135))
        path.addLine(to: point(0.0066, 0.5))
        path.addLine(to: point(0.0086, 0.4865))
        
        path.addLine(to: point(0.0648, 0.1454))
        
        path.addCurve(to: point(0.1182, 0.022),
                      control1: point(0.0777, 0.0676),
                      control2: point(0.0972, 0.022))
        
        path.addLine(to: point(0.8818, 0.022))
        path.closeSubpath()
        
        return path
    }
}

enum ColorGradientButton {
    case yellow
    case blue
    case green
    case red
    case darkBlue
    
    var colors: [Color] {
        switch self {
        case .yellow:
            return [Color.yellow1, Color.yellow2, Color.yellow3, Color.yellow4]
        case .blue:
            return [Color.blue1, Color.blue2, Color.blue3, Color.blue4]
        case .green:
            return [Color.green1, Color.green2, Color.green3, Color.green4]
        case .red:
            return [Color.red1, Color.red2, Color.red3, Color.red4]
        case .darkBlue:
            return [Color.darkBlue1, Color.darkBlue2, Color.darkBlue3, Color.darkBlue4]
        }
    }
    
    var gradient: LinearGradient {
        LinearGradient(colors: self.colors,
                       startPoint: .top,
                       endPoint: .bottom)
    }
}


#Preview {
    MainButton(style: .darkBlue, action: {}) {
        Text("Hello")
            .font(.system(size: 24, weight: .bold))
            .foregroundStyle(.white)
            .frame(width: 300, height: 60)
    }
}
