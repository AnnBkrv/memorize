//
//  memorizeApp.swift
//  memorize
//
//  Created by Anna Bukreeva on 26.09.20.
//

import SwiftUI

@main
struct memorizeApp: App {
    
    var body: some Scene {
        WindowGroup {
            let game = EmojiMemoryGame()
            EmojiMemoryGameView(ViewModel: game)
                .environmentObject(EmojiMemoryGameStore(named: "Memorize"))
        }
    }
}
