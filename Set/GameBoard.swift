//
//  ContentView.swift
//  Set
//
//  Created by Алексей Цветков on 5/30/22.
//

import SwiftUI

struct GameBoard: View {
    var body: some View {
        let setGame = SetGame(cardQuantity: 12)
        SetGameView(setGame: setGame)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameBoard()
    }
}
