//
//  SetGameModel.swift
//  Set
//
//  Created by Алексей Цветков on 5/30/22.
//

import Foundation

struct SetGameModel<CardContent> where CardContent: ThemeAppearance {
    private(set) var cards: [Card] = []
    private var selectedCards: [Card]? {
        cards.filter({ card in card.selected }).onlyThreeElements
    }
    private var removedCards: [Card] = [] {
        willSet {
            newValue.forEach { selectedCard in
                let index = cards.firstIndex { card in
                    selectedCard.id == card.id
                }
                
                if let cardIndex = index {
                    cards[cardIndex].isMatched = true
                }
            }
            
            // Remove already matched cards
            cards = cards.filter { !$0.isMatched }
        }
    }
    
    init(appearance: [CardContent]) {
        for index in 0..<appearance.count {
            cards.append(Card(id: index, content: appearance[index]))
        }
    }
    
    mutating func choose(_ cardIndex: Int) {
        if selectedCards == nil {
            cards[cardIndex].selected = !cards[cardIndex].selected
        } else {
            if cards[cardIndex].selected {
                cards[cardIndex].selected = false
            }
        }
        
        if let threeCards = selectedCards {
            let cardsContent = threeCards.map { $0.content }

            if CardContent.compare(content: cardsContent) {
                removedCards = threeCards
            }
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
}
