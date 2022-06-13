//
//  ThemeModel.swift
//  Set
//
//  Created by Алексей Цветков on 6/2/22.
//

import Foundation

struct ThemeModel {
    private(set) var set: Set<CardTheme> = []
    
    let shapes: [Shape] = [.diamond, .circle, .rectangle]
    let colors: [Color] = [.green, .red, .purple]
    let fills: [Fill] = [.opacity, .solid, .transparent]
    let quantity: [Quantity] = [.one, .two, .three]
    
    init(cardsQuantity: Int) {
        while set.count < cardsQuantity {
            set.insert(
                CardTheme(
                    shape: shapes.randomElement()!,
                    color: colors.randomElement()!,
                    fill: fills.randomElement()!,
                    quantity: quantity.randomElement()!
                )
            )
        }
    }
    
    struct CardTheme: ThemeAppearance, Hashable {
        let shape: Shape
        let color: Color
        let fill: Fill
        let quantity: Quantity
        
        static func compare(content collection: [ThemeAppearance]) -> Bool {
            var contentTypesMap: [Int: Int] = [:]
            
            func processMap(hash: Int) {
                if contentTypesMap[hash] != nil {
                    contentTypesMap[hash]! += 1
                } else {
                    contentTypesMap[hash] = 1
                }
            }
            
            for content in collection {
                processMap(hash: content.shape.hashValue)
                processMap(hash: content.color.hashValue)
                processMap(hash: content.fill.hashValue)
                processMap(hash: content.quantity.hashValue)
            }
            
            return contentTypesMap.allSatisfy { _, quantity in
                quantity == 3 || quantity == 1
            }
        }
    }
    
    enum Shape: Hashable {
        case diamond
        case rectangle
        case circle
    }
    
    enum Color: Hashable {
        case red
        case green
        case purple
    }
    
    enum Fill: Hashable {
        case opacity
        case transparent
        case solid
    }
    
    enum Quantity: Hashable {
        case one
        case two
        case three
    }
}

protocol ThemeAppearance {
    var shape: ThemeModel.Shape { get }
    var color: ThemeModel.Color { get }
    var fill: ThemeModel.Fill { get }
    var quantity: ThemeModel.Quantity { get }
    
    static func compare(content collection: [ThemeAppearance]) -> Bool
}
