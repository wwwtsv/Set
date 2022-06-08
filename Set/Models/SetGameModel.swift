//
//  SetGameModel.swift
//  Set
//
//  Created by Алексей Цветков on 5/30/22.
//

import Foundation

struct SetGameModel<CardContent> where CardContent: Hashable {
    private(set) var cards: [Card] = []
    private var selectedCards: [Card]? {
        cards.filter({ card in card.selected }).onlyThreeElements
    }
    
    init(quantity: Int, appearance: [CardContent]) {
        for index in 0...quantity {
            cards.append(Card(id: index, content: appearance[index]))
        }
    }
    
    mutating func choose(_ cardIndex: Int) {
        if let threeCards = selectedCards {
            let cardContent = threeCards.map { $0.content }

            if cardContent.matched() {
                threeCards.forEach { selectedCard in
                    let index = cards.firstIndex { card in
                        selectedCard.id == card.id
                    }
                    
                    if let cardIndex = index {
                        cards[cardIndex].isMatched = true
                    }
                }
                
                cards = cards.filter { !$0.isMatched }
            } else {
                
            }
        } else {
            cards[cardIndex].selected = !cards[cardIndex].selected
        }
    }
    
    struct Card: Identifiable {
        let id: Int
        let content: CardContent
        
        var selected = false
        var isMatched = false
    }
}

fileprivate extension Array {
    var onlyThreeElements: [Element]? {
        count == 3 ? self : nil
    }
    
    func matched() -> Bool where Element: Hashable {
        let uniqCards = Set(self)
        return uniqCards.count == 3
    }
}
