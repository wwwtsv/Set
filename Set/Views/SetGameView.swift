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
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 62))]) {
                ForEach(setGame.cards) { card in
                    CardView(card: card).onTapGesture {
                        setGame.choose(card)
                    }
                }
            }.padding()
        }
    }
}

struct CardView: View {
    let card: SetGame.Card

    var body: some View {
        ZStack {
            if card.selected {
                RoundedRectangle(cornerRadius: 12).strokeBorder(.red, lineWidth: 4)
            } else {
                RoundedRectangle(cornerRadius: 12).strokeBorder(.black, lineWidth: 3)
            }
            VStack {
                resultShape.padding()
            }
        }.aspectRatio(2/3, contentMode: .fit)
    }
    
    func shape() -> some InsettableShape {
        switch card.content.shape {
        case .diamond:
            return AnyShape(Diamond())
        case .rectangle:
            return AnyShape(Rectangle())
        case .circle:
            return AnyShape(Circle())
        }
    }
    
    @ViewBuilder
    var filledShape: some View {
        switch card.content.fill {
        case .transparent:
            shape().strokeBorder(getColor(), lineWidth: 2)
        case .solid:
            shape().foregroundColor(getColor())
        case .opacity:
            shape().foregroundColor(getColor()).opacity(0.5)
        }
    }
    
    @ViewBuilder
    var resultShape: some View {
        switch card.content.quantity {
        case .one:
            filledShape
        case .two:
            VStack {
                filledShape
                filledShape
            }
        case .three:
            VStack {
                filledShape
                filledShape
                filledShape
            }
        }
    }
    
    
    func getColor() -> Color {
        switch card.content.color {
        case .red:
            return Color.red
        case .purple:
            return Color.purple
        case .green:
            return Color.green
        }
    }
}
