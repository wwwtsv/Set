//
//  SetGame.swift
//  Set
//
//  Created by Алексей Цветков on 5/30/22.
//

import Foundation

class SetGame: ObservableObject {
    @Published var setGame: SetGameModel<Appearance>
    var setTheme: SetGameTheme
    var cardQuantity = 81
    
    var endGame: Bool {
        setGame.cards.isEmpty && setGame.deck.isEmpty
    }
    
    var cards: [Card] {
        setGame.cards
    }
    
    var hasMissMatch: IsMatch {
        setGame.isMatch
    }
    
    func dealMoreCards() {
        setGame.dealMoreCards()
    }
    
    func choose(_ selectedCard: Card) {
        let index = setGame.cards.firstIndex { card in card.id == selectedCard.id }
        if let cardIndex = index {
            setGame.choose(cardIndex)
        }
    }
    
    init() {
        setTheme = SetGameTheme(cardQuantity)
        setGame = SetGameModel<SetGameTheme.CardTheme>(appearance: Array(setTheme.set))
    }
    
    func newGame() {
        setTheme = SetGameTheme(cardQuantity)
        setGame = SetGameModel<SetGameTheme.CardTheme>(appearance: Array(setTheme.set))
    }
    
    typealias SetGame = SetGameModel<Appearance>
    
    typealias Card = SetGame.Card
    
    typealias Appearance = SetGameTheme.CardTheme
    
    typealias Shape = SetGameTheme.Shape
    
    typealias Color = SetGameTheme.Color
    
    typealias Fill = SetGameTheme.Fill
    
    typealias Quantity = SetGameTheme.Quantity
}
