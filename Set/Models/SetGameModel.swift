//
//  SetGameModel.swift
//  Set
//
//  Created by Алексей Цветков on 5/30/22.
//

import Foundation

struct SetGameModel<CardContent> where CardContent: ThemeAppearance {
    private(set) var cards: [Card] = []
    private(set) var isMatch = IsMatch.none
    private(set) var deck: [Card] = []
    private var selectedCards: [Card]? {
        cards.filter({ card in card.selected }).onlyThreeElements
    }
    
    var currentPlayer = Player.one
    var players: [String: Int] = [Player.one: 0, Player.two: 0]
    var roundTimer = 30
    
    private var removedCards: [Card] = [] {
        willSet {
            if deck.count >= 2 {
                newValue.forEach { selectedCards in
                    let index = getCardIndex(selectedCards)
                    
                    if let cardIndex = index {
                        cards[cardIndex] = deck.removeLast()
                    }
                }
            } else {
                newValue.forEach { selectedCard in
                    let index = getCardIndex(selectedCard)
                    
                    if let cardIndex = index {
                        cards[cardIndex].isMatched = true
                    }
                }
                
                // Remove already matched cards
                cards = cards.filter { !$0.isMatched }
            }
        }
    }
    
    private var deselectedCards: [Card] = [] {
        willSet {
            newValue.forEach { selectedCard in
                let index = getCardIndex(selectedCard)
                
                if let cardIndex = index {
                    cards[cardIndex].selected = false
                }
            }
        }
    }
    
    func getCardIndex(_ selectedCard: Card) -> Int? {
        cards.firstIndex { card in
            selectedCard.id == card.id
        }
    }
    
    init(appearance: [CardContent]) {
        for index in 0..<appearance.count {
            deck.append(Card(id: index, content: appearance[index]))
        }
        
        for _ in 0..<min(12, deck.count) {
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
        
        if isMatch == .none || isMatch == .no {
            cards[cardIndex].selected = !cards[cardIndex].selected
        }
        
        // Setting up whether match or not
        if let threeCards = selectedCards {
            let cardsContent = threeCards.map { $0.content }
            
            if CardContent.compare(content: cardsContent) {
                isMatch = .yes
            } else {
                isMatch = .no
            }
        } else {
            isMatch = .none
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
                }
            } else {
                addCards(3)
            }
        } else {
            addCards(3)
        }
        
        if hasValidSet {
            players[currentPlayer]! += -1
        }
    }
    
    private mutating func addCards(_ quantity: Int) {
        if deck.count >= 2 {
            for _ in 0...quantity - 1 {
                cards.append(deck.removeLast())
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

struct Player {
    static let one = "Player 1"
    static let two = "Player 2"
}

enum IsMatch {
    case none
    case yes
    case no
}

fileprivate extension Array {
    var onlyThreeElements: [Element]? {
        count == 3 ? self : nil
    }
}
