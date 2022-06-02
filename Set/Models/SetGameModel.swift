//
//  SetGameModel.swift
//  Set
//
//  Created by Алексей Цветков on 5/30/22.
//

import Foundation

struct SetGameModel<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card] = []
    
    init(quantity: Int, appearance: [CardContent]) {
        for index in 0...quantity {
            cards.append(Card(id: index, content: appearance[index]))
        }
    }
    
    struct Card: Identifiable {
        let id: Int
        let content: CardContent
        
        var selected = false
        var isMatched = false
    }
}
