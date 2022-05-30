//
//  SetGameView.swift
//  Set
//
//  Created by Алексей Цветков on 5/30/22.
//

import SwiftUI

struct SetGameView: View {
    let setGame: SetGame
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 62))]) {
            ForEach(setGame.cards) { card in
                ZStack {
                    RoundedRectangle(cornerRadius: 12).strokeBorder(.blue, lineWidth: 3)
                    Text(card.content)
                }.aspectRatio(2/3, contentMode: .fit)
            }
        }
    }
}
