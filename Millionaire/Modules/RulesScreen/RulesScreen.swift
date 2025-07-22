//
//  RulesScreen.swift
//  Millionaire
//
//  Created by Rook on 22.07.2025.
//

import SwiftUI
    
struct ContentView: View {
    
    var body: some View {
        NavigationView {
           ZStack {
               LinearGradient(gradient: Gradient(colors: [.blue, .black, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                   .ignoresSafeArea()
               VStack {
                   NavigationLink(destination: RoolesScreen(), label: {
                       Image(systemName: "questionmark.circle.fill")
                           .font(.largeTitle)
                           .foregroundColor(.white)
                           
                   })
                   .padding(.leading, 300.0)
                   Spacer()
                       
               }
               
            }
          
        }.navigationBarBackButtonHidden(true)
                
            
        }
        }
    
    



    struct RoolesScreen: View {
   
    var body: some View {
        NavigationView {
            ZStack {
                Color("RulesBackground").ignoresSafeArea()
                VStack {
                    NavigationLink(destination: ContentView(), label: {
                        Image(systemName: "chevron.left")
                            .font(.title)
                           
                
                       
                            Text("Назад")
                                .foregroundColor(.blue)
                                .font(.headline)
                    })
                    .padding(.trailing, 300.0)
                   
                    
                    VStack(alignment:.center, spacing: 20) {
                        Section {
                            Text("Правила")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        ScrollView{
                            Text("""
                                Варианты ответов: к каждому вопросу даётся 4 варианта, правильный из них — лишь один.
                                Стоимость вопросов: первые 5 вопросов — лёгкие, с 6 по 10 — серьёзные, но взяты из общих областей знаний, наиболее сложные — с 11 по 15.
                                Несгораемая сумма: её нельзя проиграть, даже если был дан неправильный ответ.
                                Подсказки: на всю игру участнику даётся 3 подсказки:
                                «50 на 50» — компьютер скроет два ошибочных ответа, оставив лишь правильный вариант и один неправильный.
                                «Звонок другу» — возможность позвонить любому знакомому и попросить подсказать ответ.
                                «Помощь зала» — зрители, пришедшие посмотреть игру, подсказывают свои варианты ответов, которые при желании можно принять.
                                Остановка игры: в любой момент можно остановить игру и забрать заработанные на данный момент деньги.
                                """).font(.title)
                                .foregroundColor(.white)
                        }
                    }
                    }
                 
                    Spacer()
                }
        }.navigationBarBackButtonHidden(true)
        
            
                
        }
        
    }


        
            
     


#Preview {
    ContentView()
}
