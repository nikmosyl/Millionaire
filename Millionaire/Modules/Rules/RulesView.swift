//
//  RulesScreen.swift
//  Millionaire
//
//  Created by Rook on 22.07.2025.
//

import SwiftUI

struct RulesView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = RulesViewModel()
    
    var body: some View {
        ZStack {
            Color("RulesBackground")
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                headerView()
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        ForEach(viewModel.rulesSections) { section in
                            rulesSection(title: section.title, content: section.content)
                                .padding(.bottom, 10)
                        }
                    }
                    .padding(5)
                    .foregroundColor(.white)
                    .font(.system(size: 17, weight: .light, design: .serif))
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 16)
        }
    }
    
    @ViewBuilder
    private func headerView() -> some View {
        HStack(spacing: 24) {
            Button(action: {
                dismiss()
            }) {
                Text("Close")
                    .foregroundColor(.blue)
                    .font(.system(size: 16))
                    .bold()
            }
            .frame(height: 44)
            
            Spacer() // Создаем пространство для центрирования
            
            Text("Rules")
                .font(.system(size: 18))
                .bold()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(65)// Центрируем текст
        }
        .frame(height: 44)
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    private func rulesSection(title: String, content: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title3)
                .bold()
            
            Text(content)
                .padding(.top, 4)
        }
    }
}

#Preview {
    RulesView()
        .preferredColorScheme(.dark)
}
