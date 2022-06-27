//
//  SetGameView.swift
//  Set
//
//  Created by Алексей Цветков on 5/30/22.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var setGame: SetGame
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    let (first, firstScore, second, secondScore) = setGame.score
                    Text("\(first) - Score: \(firstScore), ")
                    Text("\(second) - Score: \(secondScore)")
                }.padding(.bottom, 2)
                Text("Time: \(setGame.roundTimer)").onReceive(timer) { _ in
                    setGame.updateTimer(by: setGame.roundTimer - 1)
                }
            }
            AspectVGrid(items: setGame.cards, aspectRatio: 2/3) { card in
                CardView(card: card, hasMissMatch: setGame.hasMissMatch).onTapGesture {
                    setGame.choose(card)
                }.padding(4)
            }.padding()
            
            HStack {
                Button(action: {
                    setGame.newGame()
                }, label: {
                    Text("New game").font(.system(.title2))
                })
                Spacer()
                Button(action: {
                    if !setGame.endGame {
                        setGame.dealMoreCards()
                    }
                }, label: {
                    Text("Deal 3 More Cards").font(.system(.title3)).disabled(setGame.endGame)
                })
            }.padding(.horizontal)
        }
    }
}
