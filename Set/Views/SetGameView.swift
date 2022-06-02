//
//  SetGameView.swift
//  Set
//
//  Created by Алексей Цветков on 5/30/22.
//

import SwiftUI

struct SetGameView: View {
    let setGame: SetGame
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 62))]) {
            ForEach(setGame.cards) { card in
                CardView(card: card)
            }
        }.padding()
    }
}

struct CardView: View {
    let card: SetGame.Card

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12).strokeBorder(.blue, lineWidth: 3)
            VStack {
                shapes
            }
        }.aspectRatio(2/3, contentMode: .fit)
    }
    
    @ViewBuilder
    var shape: some View {
        switch card.content.shape {
        case .diamond:
            Diamond()
        default:
            Rectangle()
        }
    }
    
    @ViewBuilder
    var shapes: some View {
        switch card.content.quantity {
        case .one:
            shape
        case .two:
            VStack {
                shape
                shape
            }
        case .three:
            VStack {
                shape
                shape
                shape
            }
        }
    }
}
