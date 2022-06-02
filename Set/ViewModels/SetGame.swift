//
//  SetGame.swift
//  Set
//
//  Created by Алексей Цветков on 5/30/22.
//

import Foundation

class SetGame {
    let setGame: SetGameModel<Appearance>
    let setTheme: ThemeModel
    
    var cards: [Card] {
        setGame.cards
    }
    
    init(cardQuantity: Int) {
        setTheme = ThemeModel(cardsQuantity: cardQuantity)
        setGame = SetGameModel<ThemeModel.Appearance>(quantity: cardQuantity, appearance: Array(setTheme.set))
    }
    
    typealias SetGame = SetGameModel<Appearance>
    
    typealias Card = SetGame.Card
    
    typealias Appearance = ThemeModel.Appearance
    
    typealias Shape = ThemeModel.Shape
    
    typealias Color = ThemeModel.Color
    
    typealias Fill = ThemeModel.Fill
    
    typealias Quantity = ThemeModel.Quantity
}
