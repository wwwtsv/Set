//
//  SetGame.swift
//  Set
//
//  Created by Алексей Цветков on 5/30/22.
//

import Foundation

class SetGame: ObservableObject {
    @Published var setGame: SetGameModel<Appearance>
    let setTheme: ThemeModel
    
    var cards: [Card] {
        setGame.cards
    }
    
    func choose(_ selectedCard: Card) {
        let index = setGame.cards.firstIndex { card in card.id == selectedCard.id }
        if let cardIndex = index {
            setGame.choose(cardIndex)
        }
    }
    
    init(cardQuantity: Int) {
        setTheme = ThemeModel(cardsQuantity: cardQuantity)
        setGame = SetGameModel<ThemeModel.CardTheme>(appearance: Array(setTheme.set))
    }
    
    typealias SetGame = SetGameModel<Appearance>
    
    typealias Card = SetGame.Card
    
    typealias Appearance = ThemeModel.CardTheme
    
    typealias Shape = ThemeModel.Shape
    
    typealias Color = ThemeModel.Color
    
    typealias Fill = ThemeModel.Fill
    
    typealias Quantity = ThemeModel.Quantity
}
