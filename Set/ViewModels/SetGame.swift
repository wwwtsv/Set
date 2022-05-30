//
//  SetGame.swift
//  Set
//
//  Created by Алексей Цветков on 5/30/22.
//

import Foundation


class SetGame {
    var setGameModel = createSetGame()
    
    var cards: [SetGame.Card] {
        setGameModel.cards
    }
    
    private static func createSetGame() -> SetGame {
        SetGameModel<String, String>(quantity: 12, createCardContent, createCardColor)
    }
    
    private static func createCardContent() -> String {
        "🤡"
    }
    
    private static func createCardColor() -> String {
        "Black"
    }
    
    typealias SetGame = SetGameModel<String, String>
}
