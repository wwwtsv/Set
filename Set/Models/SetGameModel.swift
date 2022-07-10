//
//  SetGameModel.swift
//  Set
//
//  Created by Алексей Цветков on 5/30/22.
//

import Foundation

struct SetGameModel<CardContent> where CardContent: ThemeAppearance {
    private(set) var cards: [Card] = []
    private(set) var deck: [Card] = []
    private(set) var matchedCards: [Card] = []
    
    private var selectedCards: [Card]? {
        cards.filter({ card in card.selected }).onlyThreeElements
    }
    
    var currentPlayer = Player.one
    var players: [String: Int] = [Player.one: 0, Player.two: 0]
    var roundTimer = 30
    
    private var removedCards: [Card] = [] {
        willSet {
            newValue.forEach { cardToRemove in
                if let cardIndex = getCardIndex(cardToRemove) {
                    matchedCards.append(cardToRemove)
                    if !deck.isEmpty && cards.count <= Const.startCardCount {
                        cards[cardIndex] = deck.removeLast()
                    } else {
                        cards = cards.filter { !$0.isMatched }
                    }
                }
            }
            
            // Clear selection
            for card in matchedCards {
                if let cardIndex = matchedCards.firstIndex(where: { $0.id == card.id }) {
                    matchedCards[cardIndex].isMatched = false
                    matchedCards[cardIndex].selected = false
                }
            }
        }
    }
    
    private var deselectedCards: [Card] = [] {
        willSet {
            newValue.forEach { selectedCard in
                if let cardIndex = getCardIndex(selectedCard) {
                    cards[cardIndex].selected = false
                    cards[cardIndex].missMatched = false
                }
            }
        }
    }
    
    init(appearance: [CardContent]) {
        for index in 0..<appearance.count {
            deck.append(Card(id: index, content: appearance[index]))
        }
    }
    
    mutating func startGame() {
        for _ in 0..<min(Const.startCardCount, deck.count) {
            cards.append(deck.removeLast())
        }
    }
    
    mutating func choose(_ cardIndex: Int) {
        if let threeCards = selectedCards {
            let cardsContent = threeCards.map { $0.content }
            
            if !CardContent.compare(content: cardsContent) {
                deselectedCards = threeCards
            }
        }
        
        cards[cardIndex].selected = !cards[cardIndex].selected
        
        if let threeCards = selectedCards {
            let cardsContent = threeCards.map { $0.content }
            // Setting up whether match or not
            if CardContent.compare(content: cardsContent) {
                for card in threeCards {
                    if let index = getCardIndex(card) {
                        cards[index].isMatched = true
                    }
                }
            } else {
                for card in threeCards {
                    if let index = getCardIndex(card) {
                        cards[index].missMatched = true
                    }
                }
            }
        }
    }
    
    mutating func dealMoreCards(_ hasValidSet: Bool) {
        if let threeCards = selectedCards {
            let cardsContent = threeCards.map { $0.content }
            
            if (CardContent.compare(content: cardsContent)) {
                removedCards = threeCards
                if players[currentPlayer] != nil {
                    if roundTimer > 0 {
                        players[currentPlayer]! += 3
                    } else {
                        players[currentPlayer]! += 1
                    }
                    currentPlayer = players.keys.first(where: { $0 != currentPlayer })!
                    roundTimer = 30
                }
            } else {
                if hasValidSet {
                    players[currentPlayer]! += -1
                }
                addCards(3)
            }
        } else {
            if hasValidSet {
                players[currentPlayer]! += -1
            }
            addCards(3)
        }
    }
    
    private mutating func addCards(_ quantity: Int) {
        if deck.count >= 2 {
            for _ in 0...quantity - 1 {
                cards.append(deck.removeLast())
            }
        }
    }
    
    func getCardIndex(_ selectedCard: Card) -> Int? {
        cards.firstIndex { card in
            selectedCard.id == card.id
        }
    }
    
    struct Card: Identifiable {
        let id: Int
        let content: CardContent
        
        var selected = false
        var isMatched = false
        var missMatched = false
    }
}

struct Player {
    static let one = "Player 1"
    static let two = "Player 2"
}

fileprivate extension Array {
    var onlyThreeElements: [Element]? {
        count == 3 ? self : nil
    }
}

private struct Const {
    static let startCardCount = 12
}
