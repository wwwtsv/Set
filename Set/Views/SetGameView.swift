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
    
    var body: some View {
        VStack {
            score
            ZStack(alignment: .bottom) {
                cardsField
                HStack {
                    deck
                    Spacer()
                    discardPile
                }.padding(.horizontal)
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
                if !setGame.isNotStarted {
                    setGame.updateTimer(by: setGame.roundTimer - 1)
                }
            }
        }
    }
    
    var cardsField: some View {
        AspectVGrid(items: setGame.cards, aspectRatio: 2/3) { card in
            CardView(card: card)
                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                .transition(.asymmetric(insertion: .identity, removal: .scale))
                .padding(4)
                .onTapGesture {
                    setGame.choose(card)
                }
        }.padding()
    }
    
    var deck: some View {
        ZStack {
            ForEach(setGame.deck) { card in
                let cardIndex = setGame.deck.firstIndex(where: { $0.id == card.id }) ?? 0
                CardView(card: card)
                    .reverse()
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .offset(x: CGFloat(cardIndex) * Const.cardOffset, y: CGFloat(cardIndex) * Const.cardOffset)
            }
        }
        .frame(width: Const.cardWidth, height: Const.cardHeight)
        .onTapGesture() {
            withAnimation {
                if setGame.isNotStarted {
                    setGame.startGame()
                } else if !setGame.ended {
                    setGame.dealMoreCards()
                }
            }
        }
    }
    
    var discardPile: some View {
        ZStack {
            ForEach(setGame.matchedCards) { card in
                let cardIndex = setGame.matchedCards.firstIndex(where: { $0.id == card.id }) ?? 0
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .offset(x: CGFloat(cardIndex) * Const.cardOffset, y: CGFloat(cardIndex) * Const.cardOffset)
            }
        }
        .frame(width: Const.cardWidth, height: Const.cardHeight)
    }
    
    var controls: some View {
        Button(action: {
            withAnimation {
                setGame.newGame()
            }
        }, label: {
            Text("New game").font(.system(.title2))
        })
    }
}

private struct Const {
    static let cardAspectRatio: CGFloat = 2/3
    static let cardHeight: CGFloat = 123
    static let cardWidth: CGFloat = cardAspectRatio * cardHeight
    static let cardOffset: CGFloat = 0.15
}
