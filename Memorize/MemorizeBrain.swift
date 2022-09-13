//
//  MemorizeBrain.swift
//  Memorize
//
//  Created by Maikon Ferreira on 03/12/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var Cards: Array<Card>
    
    private var indexOfTheOnlyAndOnlyFaceUp: Int? {
        get { Cards.indices.filter { Cards[$0].FaceUp }.only }
        set {
            for index in Cards.indices {
                Cards[index].FaceUp = index == newValue
            }
        }
    }
    
    mutating func choose (card: Card) {
        if let chosenIndex: Int = Cards.firstIndex(matching: card), !Cards[chosenIndex].FaceUp, !Cards[chosenIndex].Matched {
            if let potentialMatchIndex = indexOfTheOnlyAndOnlyFaceUp {
                if Cards[chosenIndex].Content == Cards[potentialMatchIndex].Content {
                    Cards[chosenIndex].Matched = true
                    Cards[potentialMatchIndex].Matched = true
                }
                Cards[chosenIndex].FaceUp = true
            } else {
                indexOfTheOnlyAndOnlyFaceUp = chosenIndex
            }
        }
    }
    
    
    
    
    init (numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        Cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            Cards.append(Card(Content: content, id: pairIndex*2))
            Cards.append(Card(Content: content, id: pairIndex*2+1))
        }
        Cards.shuffle()
    }
    struct Card: Identifiable {
        var FaceUp: Bool = false {
            didSet {
                if FaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var Matched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var Content: CardContent
        var id: Int
        
        
        var bonusTimeLimit: TimeInterval = 6
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        
        var lastFaceUpDate: Date?
        var pastFaceUpTime: TimeInterval = 0
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            Matched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            FaceUp && !Matched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
        
        
        
        
        
        
        
        
        
    }
}
