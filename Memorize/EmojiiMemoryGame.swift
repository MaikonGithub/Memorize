//
//  EmojiiMemoryGame.swift
//  Memorize
//
//  Created by Maikon Ferreira on 03/12/21.
//

import SwiftUI

class EmojiiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiiMemoryGame.createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let emojiis = ["👻","🎃","🕷","🐵","🍄","🍁"]
                        return MemoryGame<String>(numberOfPairsOfCards: emojiis.count) { pairIndex in
            return emojiis[pairIndex]
            
        }
    }
    
    //MARK:  - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.Cards
    }
    // MARK: - Intents(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose (card: card)
    }
    func resetGame() {
        model = EmojiiMemoryGame.createMemoryGame()
    }

}



