//
//  CardView.swift
//  Set
//
//  Created by Алексей Цветков on 6/16/22.
//

import SwiftUI

struct CardView: View {
    let card: SetGame.Card

    var body: some View {
        VStack {
            switch card.content.shape {
            case .circle: cloneShapes(shape: Circle())
            case .diamond: cloneShapes(shape: Diamond())
            case .rectangle: cloneShapes(shape: Rectangle())
            }
        }
        .padding(12)
        .cardify(card: card)
    }
    
    func fillShape<T: InsettableShape>(shape: T) -> some View {
        return VStack {
            switch card.content.fill {
            case .transparent:
                shape.strokeBorder(getColor(), lineWidth: Const.shapeLineWidth)
                    .aspectRatio(3/2, contentMode: .fit)
            case .solid:
                shape.foregroundColor(getColor())
                    .aspectRatio(3/2, contentMode: .fit)
            case .opacity:
                shape.foregroundColor(getColor())
                    .opacity(Const.shapeOpacity)
                    .aspectRatio(3/2, contentMode: .fit)
            }
        }
    }
    
    func cloneShapes<T: InsettableShape>(shape: T) -> some View {
        return VStack {
            switch card.content.quantity {
            case .one:
                fillShape(shape: shape)
            case .two:
                fillShape(shape: shape)
                fillShape(shape: shape)
            case .three:
                fillShape(shape: shape)
                fillShape(shape: shape)
                fillShape(shape: shape)
            }
        }.transition(.identity)
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

struct Cardify: ViewModifier {
    let card: SetGame.Card
    
    func body(content: Content) -> some View {
        ZStack {
            let rectangle = RoundedRectangle(cornerRadius: Const.cardRadius)
            rectangle.fill(Color(red: 255 / 255, green: 253 / 255, blue: 208 / 255))
            if card.missMatched {
                rectangle.strokeBorder(.red, lineWidth: Const.selectedCardLineWidth)
            } else if card.isMatched {
                rectangle.strokeBorder(.green, lineWidth: Const.selectedCardLineWidth)
            } else if card.selected {
                rectangle.strokeBorder(.blue, lineWidth: Const.selectedCardLineWidth)
            } else {
                rectangle.strokeBorder(.black, lineWidth: Const.cardLineWidth)
            }
            content
        }
    }
}

struct Reversed: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: Const.cardRadius)
                .fill(Color(red: 255 / 255, green: 253 / 255, blue: 208 / 255))
            RoundedRectangle(cornerRadius: Const.cardRadius)
                .strokeBorder(.black, lineWidth: Const.cardLineWidth)
            Text("Set").font(.system(size: 24, weight: .bold, design: .default))
        }
    }
}

extension View {
    func cardify(card: SetGame.Card) -> some View {
        self.modifier(Cardify(card: card))
    }
    func reverse() -> some View {
        self.modifier(Reversed())
    }
}

private struct Const {
    static let cardLineWidth: CGFloat = 2
    static let selectedCardLineWidth: CGFloat = 4
    static let shapeLineWidth: CGFloat = 2
    static let cardRadius: CGFloat = 12
    static let shapeOpacity: CGFloat = 0.4
}
