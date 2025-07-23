//
//  LevelListModel.swift
//  Millionaire
//
//  Created by DimaTru on 23.07.2025.
//

import Foundation

struct DataButton: Identifiable {
    let id = UUID()
    let number: String
    let dollar: String
    let color: ColorGradientButton
}

struct LevelListModel {
   static let buttons: [DataButton] = [
        DataButton(number: "1:", dollar: "$ 500", color: .darkBlue),
        DataButton(number: "2:", dollar: "$ 1,000", color: .darkBlue),
        DataButton(number: "3:", dollar: "$ 2,000", color: .darkBlue),
        DataButton(number: "4:", dollar: "$ 3,000", color: .darkBlue),
        DataButton(number: "5:", dollar: "$ 5,000", color: .blue),
        DataButton(number: "6:", dollar: "$ 7,500", color: .darkBlue),
        DataButton(number: "7:", dollar: "$ 10,000", color: .darkBlue),
        DataButton(number: "8:", dollar: "$ 12,500", color: .darkBlue),
        DataButton(number: "9:", dollar: "$ 15,000", color: .darkBlue),
        DataButton(number: "10:", dollar: "$ 25,500", color: .blue),
        DataButton(number: "11:", dollar: "$ 50,000", color: .darkBlue),
        DataButton(number: "12:", dollar: "$ 100,000", color: .darkBlue),
        DataButton(number: "13:", dollar: "$ 250,000", color: .darkBlue),
        DataButton(number: "14:", dollar: "$ 500,000", color: .darkBlue),
        DataButton(number: "15:", dollar: "$ 1,000,000", color: .yellow)
    ]
}

