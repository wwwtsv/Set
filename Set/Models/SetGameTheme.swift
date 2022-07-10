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
        while set.count < min(cardsQuantity, ThemeConst.maxCardCount) {
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
    
    func hasValidSet(content collection: [ThemeAppearance]) -> Bool {
        for i in 0..<collection.count {
            for j in i + 1..<collection.count {
                for k in j + 1..<collection.count {
                    if CardTheme.compare(content: [collection[i], collection[j], collection[k]]) {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    struct CardTheme: ThemeAppearance, Hashable {
        let shape: Shape
        let color: Color
        let fill: Fill
        let quantity: Quantity
        
        // TODO: move it in ViewModel
        static func compare(content collection: [ThemeAppearance]) -> Bool {
            // TODO: change compare logic using first card flags
            let contentTypesMap = createContentMap(from: collection)
            
            return contentTypesMap.allSatisfy { _, quantity in
                quantity == 3 || quantity == 1
            }
        }
    }
    
    enum Shape: Int {
        case diamond = 0
        case rectangle = 1
        case circle = 2
    }
    
    enum Color: Int {
        case red = 3
        case green = 4
        case purple = 5
    }
    
    enum Fill: Int {
        case opacity = 6
        case transparent = 7
        case solid = 8
    }
    
    enum Quantity: Int {
        case one = 9
        case two = 10
        case three = 11
    }
    
    private struct ThemeConst {
        static let maxCardCount = 81
    }
}

func createContentMap(from collection: [ThemeAppearance]) -> [Int: Int] {
    var contentTypesMap: [Int: Int] = [:]
    
    func processMap(hash: Int) {
        if contentTypesMap[hash] != nil {
            contentTypesMap[hash]! += 1
        } else {
            contentTypesMap[hash] = 1
        }
    }
    
    for content in collection {
        processMap(hash: content.shape.rawValue)
        processMap(hash: content.color.rawValue)
        processMap(hash: content.fill.rawValue)
        processMap(hash: content.quantity.rawValue)
    }
    
    return contentTypesMap
}

protocol ThemeAppearance {
    var shape: SetGameTheme.Shape { get }
    var color: SetGameTheme.Color { get }
    var fill: SetGameTheme.Fill { get }
    var quantity: SetGameTheme.Quantity { get }
    
    static func compare(content collection: [ThemeAppearance]) -> Bool
}

fileprivate extension Array {
    var hasMatchedContent: Bool {
        count == 3
    }
}
