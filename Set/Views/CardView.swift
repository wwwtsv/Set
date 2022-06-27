//
//  CardView.swift
//  Set
//
//  Created by Алексей Цветков on 6/16/22.
//

import SwiftUI

struct CardView: View {
    let card: SetGame.Card
    let hasMissMatch: IsMatch

    var body: some View {
        ZStack {
            let rectangle = RoundedRectangle(cornerRadius: Const.cardRadius)
            rectangle.fill(Color(red: 255 / 255, green: 253 / 255, blue: 208 / 255))
            if card.selected {
                switch hasMissMatch {
                case .none:
                    rectangle.strokeBorder(.blue, lineWidth: Const.selectedCardLineWidth)
                case .yes:
                    rectangle.strokeBorder(.green, lineWidth: Const.selectedCardLineWidth)
                case .no:
                    rectangle.strokeBorder(.red, lineWidth: Const.selectedCardLineWidth)
                }
            } else {
                rectangle.strokeBorder(.black, lineWidth: Const.cardLineWidth)
            }
            VStack {
                switch card.content.shape {
                case .circle: cloneShapes(shape: Circle())
                case .diamond: cloneShapes(shape: Diamond())
                case .rectangle: cloneShapes(shape: Rectangle())
                }
            }.padding(12)
        }
    }
    
    func fillShape<T: InsettableShape>(shape: T) -> some View {
        return VStack {
            switch card.content.fill {
            case .transparent:
                shape.strokeBorder(getColor(), lineWidth: Const.shapeLineWidth)
            case .solid:
                shape.foregroundColor(getColor())
            case .opacity:
                shape.foregroundColor(getColor()).opacity(Const.shapeOpacity)
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
    
    private struct Const {
        static let cardLineWidth: CGFloat = 2
        static let selectedCardLineWidth: CGFloat = 4
        static let shapeLineWidth: CGFloat = 2
        static let cardRadius: CGFloat = 12
        static let shapeOpacity: CGFloat = 0.4
    }
}
