//
//  MemoryGame.swift
//  memorize
// the MODEL of the game
//  Created by Anna Bukreeva on 27.09.20.
//

import Foundation
//struct is the go-to data structure in Swift

struct MemoryGame<CardContent> where CardContent : Equatable{
//    having card content as an array type means that when we want to initialize this struct, we will have to specify the content. like mmrGame<Int> or String
    private(set) var cards: Array<Card>
    
    private(set) var score : Int
  

  
 
    private var indexOfTheOneAndOnlyFaceUpCard : Int?{
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices{
                cards[index].isFaceUp = index == newValue
                }
            }
        }
    
    private var previouslySeenCards = [CardContent]()
    
    mutating private func deselectAllCards() {
        for i in 0 ..< cards.count {
            cards[i].didntGetMatchedInThisRound = false
            if cards[i].isMatched{
                cards[i].isHidden = true
            }
        }
    }
 
    mutating func choose(card: Card) {
        let chosenIndex = cards.firstIndex(matching: card)
        let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard
        cards[chosenIndex!].didntGetMatchedInThisRound = false
        deselectAllCards()

//        
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
              
                if chosenIndex == potentialMatchIndex {
                    cards[chosenIndex].isFaceUp = false
                }
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                    
                } else {
                    if previouslySeenCards.contains(cards[potentialMatchIndex].content) {
                        score -= 1
                    } else {
                        previouslySeenCards.append(cards[potentialMatchIndex].content)
                    }
                    if previouslySeenCards.contains(cards[chosenIndex].content) {
                        score -= 1
                    } else {
                        previouslySeenCards.append(cards[chosenIndex].content)
                    }
                    cards[potentialMatchIndex].didntGetMatchedInThisRound = true
                    cards[chosenIndex].didntGetMatchedInThisRound = true
                    
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
        if chosenIndex == potentialMatchIndex {
            cards[chosenIndex!].isFaceUp = false

        }
    }
        
    
    init(numberOfPairsOfCards:Int, cardContentFactory: (Int)->CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
//            you don't have to specify the type of content cause it's inferred
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
        score = 0
//        we don't have to initialize a struct, but we had to here
    }
    
    mutating func addMoreCards(content:CardContent) {
        cards.append(Card(content: content, id: cards.count))
        cards.append(Card(content: content, id: cards.count))
        cards.shuffle()
    }
    
    struct Card: Identifiable { // this struct would be referred to as MemoryGame.Card if used outside this struct. that's like its full name. so you could declare structs of the same name in other structs.
//        my name is card. MemoryGame.card
        var isFaceUp:Bool = false {
            didSet{
                if isFaceUp{
                    startUsingBonusTime()
                }
                else{
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched:Bool = false{
            didSet{
                stopUsingBonusTime()
            }
        }
    
        var isHidden = false
        
        var content:CardContent // the "don't care" type. we don't care what is on the card, so we just made a type up.
        var id:Int
        
        var didntGetMatchedInThisRound : Bool = false
        
        
        // Bonus time implementation
        var bonusTimeLimit : TimeInterval = 6
        
        private var faceUpTime : TimeInterval{
            if let lastFaceUpDate = self.lastFaceUpDate{
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)}
            else{
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate : Date?
        var pastFaceUpTime : TimeInterval = 0
        
        var bonusTimeRemaining : TimeInterval{
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining : Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        var hasEarnedBonus : Bool{
            isMatched && bonusTimeRemaining > 0
        }
        var isConsumingBonusTime : Bool{
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime(){
            if isConsumingBonusTime, lastFaceUpDate == nil{
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime(){
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
    
}
