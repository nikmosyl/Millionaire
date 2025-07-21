//
//  MainButton.swift
//  Millionaire
//
//  Created by DimaTru on 21.07.2025.
//

import SwiftUI

struct MainButton: View {
    
    //MARK: выбираем вид заголовка для кнопки
    enum Content {
        case title(String)
        case doubleTitle(String, String)
        case doubleTitleSpaser(String, String)
    }
    
    //MARK: Передаем в кнопку заголовок + цвет + действие
    let content: Content
    var action: () -> Void
    var style: ColorGradientButton
    
    //MARK: тело кнопки
    var body: some View {
        Button(action: action) {
            
            //MARK: через кейсы задаем нужный вид кнопки
            switch content {
                
            case .title(let title):
                Text(title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .padding(.vertical, 16)
                
            case .doubleTitle(let leftTitle, let rightTitle):
                HStack {
                    Text(leftTitle)
                        .foregroundStyle(.yellow1)
                        .padding(.leading, 24)
                    Text(rightTitle)
                        .foregroundStyle(.white)
                    Spacer()
                }
                .font(.system(size: 18, weight: .bold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                
            case .doubleTitleSpaser(let leftTitle, let rightTitle):
                HStack {
                    Text(leftTitle)
                    Spacer()
                    Text(rightTitle)
                }
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .padding(.horizontal, 24)
            }
        }
        .background(
            ArrowShapeButton()
                .fill(style.gradient)
        )
        .overlay(
            ArrowShapeButton()
                .stroke(Color.white, lineWidth: 3)
        )
        .padding(.horizontal, 32)
    }
}

//MARK: рисуем форму кнопки
struct ArrowShapeButton: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        let inset: CGFloat = rect.height * 0.5

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

//MARK: выбор цвета кнопки
enum ColorGradientButton {
    case yellow
    case blue
    case green
    case red
    case darkBlue
    
    //MARK: через кейсы задаем нужный массив цветов
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
    
    //MARK: направление градиента
    var gradient: LinearGradient {
        LinearGradient(colors: self.colors,
                       startPoint: .top,
                       endPoint: .bottom)
    }
}


#Preview {
    MainButton(content: .title("Hello world!"), action: { }, style: .darkBlue)
}
