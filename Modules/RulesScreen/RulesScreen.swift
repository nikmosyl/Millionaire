//
//  RulesScreen.swift
//  Millionaire
//
//  Created by Rook on 22.07.2025.
//

import SwiftUI
    

    struct RoolesScreen: View {
   
    var body: some View {
        NavigationView {
            ZStack {
                Color("RulesBackground").ignoresSafeArea()
                VStack(alignment:.leading) {
                    
                    HStack {
                        NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true), label: {
                            Image(systemName: "chevron.left")
                                .font(.title)
                            
                            Text("Назад")
                                .foregroundColor(.blue)
                                .font(.headline)
                                .multilineTextAlignment(.leading)
                            
                            VStack {
                                Text("Правила")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 60)
                            }
                        })
                    }
                  
                    
     
                    VStack(alignment:.center, spacing: 20) {
                        
                        ScrollView{
                            Text("""
                                Варианты ответов:
                                
                                к каждому вопросу даётся 4 варианта, правильный из них — лишь один.
                                
                                Стоимость вопросов: первые 5 вопросов — лёгкие, с 6 по 10 — серьёзные, но взяты из общих областей знаний, наиболее сложные — с 11 по 15.
                                
                                Несгораемая сумма: её нельзя проиграть, даже если был дан неправильный ответ.
                                
                                Подсказки: на всю игру участнику даётся 3 подсказки:
                                «50 на 50» — компьютер скроет два ошибочных ответа, оставив лишь правильный вариант и один неправильный.
                                
                                «Звонок другу» — возможность позвонить любому знакомому и попросить подсказать ответ.
                                
                                «Помощь зала» — зрители, пришедшие посмотреть игру, подсказывают свои варианты ответов, которые при желании можно принять.
                                
                                Остановка игры: в любой момент можно остановить игру и забрать заработанные на данный момент деньги.
                                """).font(.title)
                                .italic(true)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                                .padding()
                                
                        }
                    }
                    }
                 
                    Spacer()
                }
        }.navigationBarBackButtonHidden(true)
        
            
                
        }
        
    }


        
            
     


#Preview {
    RoolesScreen()
}
