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
    
    var ended: Bool {
        setGame.cards.isEmpty && setGame.deck.isEmpty
    }
    
    var isNotStarted: Bool {
        setGame.cards.isEmpty && setGame.deck.count > 0
    }
    
    var roundTimer: Int {
        setGame.roundTimer
    }
    
    var score: (String, Int, String, Int) {
        ("Player 1", setGame.players["Player 1"]!, "Player 2", setGame.players["Player 2"]!)
    }
    
    var cards: [Card] {
        setGame.cards
    }
    
    var deck: [Card] {
        setGame.deck
    }
    
    var matchedCards: [Card] {
        setGame.matchedCards
    }
    
    func dealMoreCards() {
        let hasValidSet = setTheme.hasValidSet(content: setGame.cards.map { card in card.content })
        setGame.dealMoreCards(hasValidSet)
    }
    
    func updateTimer(by time: Int) {
        setGame.roundTimer = max(0, time)
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
    
    func startGame() {
        setGame.startGame()
    }
    
    typealias SetGame = SetGameModel<Appearance>
    
    typealias Card = SetGame.Card
    
    typealias Appearance = SetGameTheme.CardTheme
    
    typealias Shape = SetGameTheme.Shape
    
    typealias Color = SetGameTheme.Color
    
    typealias Fill = SetGameTheme.Fill
    
    typealias Quantity = SetGameTheme.Quantity
}
