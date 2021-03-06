//
//  ViewController.swift
//  memorize
// View Model!!!!
// handles the communication between the ui view and the model
//  Created by Anna Bukreeva on 27.09.20.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    
    @Published private var currentTheme: Theme
    @EnvironmentObject var store : EmojiMemoryGameStore
    var explainNoMoreEmojisToAdd = false
    @Published private var model : MemoryGame<String>
//    @published calls objectWillChange.send() every time var model changes
    var emojisNotInThisGame : [String]
    
    
    init(currentTheme : Theme = EmojiMemoryGameStore().setOfThemes.randomElement()!) {
        self.currentTheme = currentTheme // should be either random on start up or chosen by the user
        (model, emojisNotInThisGame) = Self.createMemoryGame(emojiTheme : currentTheme)
//        _store = EnvironmentObject(wrappedValue : EmojiMemoryGameStore()) // i think i might have this error because i didn't initialize emojiStore in the class. it works in another file because that's a struct so all variables get initalized automatically. but here... maybe i'm not initializing the store correctly?
    }

    private static func createMemoryGame(emojiTheme : Theme) -> (MemoryGame<String>, [String]) {
        var emojis = emojiTheme.emojis
        emojis.shuffle()
        let numberOfPairsOfCards = emojiTheme.cardsToShow ?? Int.random(in: 2...5)
        let emojisNotInThisGame = Array(emojis.suffix(emojis.count - numberOfPairsOfCards))
        let model = MemoryGame<String>(numberOfPairsOfCards: numberOfPairsOfCards) {pairIndex in
            return emojis[pairIndex]
        }

        return (model, emojisNotInThisGame)
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards.filter{!$0.isHidden}
    }
    
    var colorTheme : UIColor.RGB {currentTheme.color}
   
    var nameTheme : String { currentTheme.topic}
    
    var score: Int {
            model.score
    }
    
//    var setOfThemes : [Theme]{
//        store.setOfThemes
//    }
    
    func dealMore() {
        explainNoMoreEmojisToAdd = false
        if emojisNotInThisGame.count == 0{
            print("No more cards to add!")
            explainNoMoreEmojisToAdd = true
            return
        }
        let emojiIndex = Int.random(in: 0...emojisNotInThisGame.count-1)
        let emoji = emojisNotInThisGame[emojiIndex]
        model.addMoreCards(content: emoji)
        emojisNotInThisGame.remove(at: emojiIndex)
    }
    
    
    func newGame(gameTheme : Theme = EmojiMemoryGameStore().setOfThemes.randomElement()!) {
        (model, emojisNotInThisGame) = Self.createMemoryGame(emojiTheme: gameTheme)
        currentTheme = gameTheme
        print("json = \(currentTheme.json?.utf8 ?? "nil")")
    }

    
//    intent(s)
    func choose(card:MemoryGame<String>.Card){
        model.choose(card: card)
    }
    
   
}

