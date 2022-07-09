//
//  SetGameView.swift
//  Set
//
//  Created by Алексей Цветков on 5/30/22.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var setGame: SetGame
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Namespace private var dealingNamespace
    
    @State private var dealt: Set<Int> = []
    
    private func deal(card: SetGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(card: SetGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    var body: some View {
        VStack {
            score
            ZStack(alignment: .bottom) {
                cardsField
                deck
            }
            controls
        }
        
    }
    
    var score: some View {
        VStack {
            HStack {
                let (first, firstScore, second, secondScore) = setGame.score
                Text("\(first) - Score: \(firstScore), ")
                Text("\(second) - Score: \(secondScore)")
            }.padding(.bottom, 2)
            Text("Time: \(setGame.roundTimer)").onReceive(timer) { _ in
                setGame.updateTimer(by: setGame.roundTimer - 1)
            }
        }
    }
    
    var cardsField: some View {
        AspectVGrid(items: setGame.cards, aspectRatio: 2/3) { card in
            if isUndealt(card: card) {
                Color.clear
            } else {
                CardView(card: card, hasMissMatch: setGame.hasMissMatch)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .scale))
                    .padding(4)
                    .onTapGesture {
                        setGame.choose(card)
                    }
            }
        }.padding()
    }
    
    var deck: some View {
        ZStack {
            ForEach(setGame.cards.filter(isUndealt)) { card in
                CardView(card: card, hasMissMatch: setGame.hasMissMatch)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: Const.cardWidth, height: Const.cardHeight)
        .onTapGesture() {
            setGame.cards.forEach { card in
                withAnimation(.easeInOut(duration: 3)) {
                    deal(card: card)
                }
            }
        }
    }
    
    var controls: some View {
        HStack {
            Button(action: {
                withAnimation(.easeInOut(duration: 3)) {
                    dealt = []
                }
                setGame.newGame()
            }, label: {
                Text("New game").font(.system(.title2))
            })
            Spacer()
            Button(action: {
                if !setGame.endGame {
                    setGame.dealMoreCards()
                }
            }, label: {
                Text("Deal").font(.system(.title3)).disabled(setGame.endGame)
            })
        }.padding(.horizontal, 24)
    }
}

private struct Const {
    static let cardAspectRatio: CGFloat = 2/3
    static let cardHeight: CGFloat = 123
    static let cardWidth: CGFloat = cardAspectRatio * cardHeight
}
