//
//  GameOverView.swift
//  Millionaire
//
//  Created by Aleksandr Zhazhoyan on 24.07.2025.
//

import SwiftUI

struct GameOverView: View {
    @StateObject private var viewModel = GameOverViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 195, height: 195)
            
            Text("Game Over!")
                .font(.system(size: 32))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
            
            Text("Level \(viewModel.result.level)")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.7))
            
            HStack(spacing: 6) {
                Text("$\(viewModel.result.score)")
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontWeight(.semibold)
                
                Image("dollar")
            }
            
            Spacer()
            
            MainButton(style: .yellow) {
                viewModel.startNewGame()
            } content: {
                Text("New Game")
                    .frame(width: 311, height: 62)
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
                    .font(.system(size: 24))
            }
            .padding(.horizontal)
            
            MainButton(style: .darkBlue) {
                viewModel.mainScreen()
            } content: {
                Text("Main screen")
                    .frame(width: 311, height: 62)
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
                    .font(.system(size: 24))
            }
            .padding(.horizontal)
        }
        .background(
            LinearGradient(colors: [Color.blue.opacity(0.9), Color.black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            )
    }
}

#Preview {
    GameOverView()
}
