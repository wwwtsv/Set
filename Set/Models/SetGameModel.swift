//
//  SetGameModel.swift
//  Set
//
//  Created by Алексей Цветков on 5/30/22.
//

import Foundation

struct SetGameModel<CardContent, Color> {
    private(set) var cards: [Card] = []
    
    init(quantity: Int, _ createCardContent: () -> CardContent, _ createCardColor: () -> Color) {
        for i in 0..<quantity {
            cards.append(Card(id: i, content: createCardContent(), color: createCardColor()))
        }
    }
    
    
    
    struct Card: Identifiable {
        let id: Int
        let content: CardContent
        let color: Color
        
        var selected = false
        var isMatched = false
    }
}
