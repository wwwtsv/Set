//
//  ThemeModel.swift
//  Set
//
//  Created by Алексей Цветков on 6/2/22.
//

import Foundation

struct ThemeModel {
    private(set) var set: Set<Appearance> = []
    
    let shapes: [Shape] = [.diamond, .oval, .wave]
    let colors: [Color] = [.green, .red, .purple]
    let fills: [Fill] = [.opacity, .solid, .transparent]
    let quantity: [Quantity] = [.one, .two, .three]
    
    init(cardsQuantity: Int) {
        while set.count <= cardsQuantity {
            set.insert(
                Appearance(
                    shape: shapes.randomElement()!,
                    color: colors.randomElement()!,
                    fill: fills.randomElement()!,
                    quantity: quantity.randomElement()!
                )
            )
        }
    }
    
    struct Appearance: Hashable {
        let shape: Shape
        let color: Color
        let fill: Fill
        let quantity: Quantity
    }
    
    enum Shape {
        case diamond
        case oval
        case wave
    }
    
    enum Color {
        case red
        case green
        case purple
    }
    
    enum Fill {
        case opacity
        case transparent
        case solid
    }
    
    enum Quantity {
        case one
        case two
        case three
    }
}
