//
//  SetGameView.swift
//  Set
//
//  Created by Алексей Цветков on 5/30/22.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var setGame: SetGame
    
    var body: some View {
        VStack {
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
