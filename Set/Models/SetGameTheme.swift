//
//  ThemeModel.swift
//  Set
//
//  Created by Алексей Цветков on 6/2/22.
//

import Foundation

struct SetGameTheme {
    private(set) var set: Set<CardTheme> = []
    
    let shapes: [Shape] = [.diamond, .circle, .rectangle]
    let colors: [Color] = [.green, .red, .purple]
    let fills: [Fill] = [.opacity, .solid, .transparent]
    let quantity: [Quantity] = [.one, .two, .three]
    
    init(_ cardsQuantity: Int) {
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
    
    enum Shape: Int, Hashable {
        case diamond = 0
        case rectangle = 1
        case circle = 2
    }
    
    enum Color: Int, Hashable {
        case red = 3
        case green = 4
        case purple = 5
    }
    
    enum Fill: Int, Hashable {
        case opacity = 6
        case transparent = 7
        case solid = 8
    }
    
    enum Quantity: Int, Hashable {
        case one = 9
        case two = 10
        case three = 11
    }
}

protocol ThemeAppearance {
    var shape: SetGameTheme.Shape { get }
    var color: SetGameTheme.Color { get }
    var fill: SetGameTheme.Fill { get }
    var quantity: SetGameTheme.Quantity { get }
    
    static func compare(content collection: [ThemeAppearance]) -> Bool
}
