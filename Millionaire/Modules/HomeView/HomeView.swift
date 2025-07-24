//
//  HomeView.swift
//  Millionaire
//
//  Created by Aleksandr Zhazhoyan on 22.07.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var showRules = false
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 16) {
                Spacer()
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 195)
                
                Text("Who Wants\nto be a Millionaire")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                
                if viewModel.gameState.bestScore > 0 {
                    VStack(spacing: 4) {
                        Text("All-time Best Score")
                            .foregroundStyle(.white.opacity(0.5))
                            .font(.subheadline)
                        
                        HStack(spacing: 6) {
                            Image("dollar")
                            
                            Text("$\(viewModel.gameState.bestScore)")
                                .foregroundStyle(.white)
                                .font(.title)
                                .fontWeight(.semibold)
                        }
                    }
                }
                
                Spacer()
                
                if viewModel.gameState.continueGame {
                    Button {
                        viewModel.continGame()
                    } label: {
                        Text("Continue Game")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.yellow)
                            .cornerRadius(12)
                            .foregroundStyle(.black)
                            .fontWeight(.bold)
                    }
                    .padding(.horizontal)
                    
                    Button {
                        viewModel.startNewGame()
                    } label: {
                        Text("New Game")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.green)
                            .cornerRadius(12)
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                    }
                    .padding(.horizontal)
                } else {
                    Button {
                        viewModel.startNewGame()
                    } label: {
                        Text("New Game")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.green)
                            .cornerRadius(12)
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                    }
                    .padding(.horizontal)
                }
                Spacer(minLength: 20)
            }
            .background(
                LinearGradient(colors: [Color.blue.opacity(0.9), Color.black], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
            )
            .toolbar {
                Button {
                    showRules = true
                } label: {
                    Image(systemName: "questionmark.circle")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding()
                        .foregroundStyle(.white)
                }
            }
            .sheet(isPresented: $showRules) {
                Rules()
                    .presentationDetents([.large])
            }
        }
    }
}
#Preview {
    HomeView()
        .preferredColorScheme(.dark)
}
