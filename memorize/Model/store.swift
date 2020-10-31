//
//  store.swift
//  memorize
//
//  Created by Anna Bukreeva on 26.10.20.
//

import SwiftUI
import Combine

//class EmojiMemoryGameStore: ObservableObject {
//    
////    @Published var storedThemes = [theme]()
//    @Published var storedThemes = setOfThemes
//    private(set) var name: String
//    private var autosave: AnyCancellable? //publisher to emit changes
//    
//    init(named name: String = "Memorize") {
//        self.name = name
//        let defaultsKey = "EmojiMemoryGame.\(name)"
//        
//        // trying to decode json data stored in user defaults if exists
//        let data = UserDefaults.standard.data(forKey: defaultsKey)
//        if data != nil, let newStoredThemes = try? JSONDecoder().decode([theme].self, from: data!) {
//            storedThemes = newStoredThemes
//        } else {
////            addThemesToTheGame() // initial one-time setup
//        }
//        
//        // encdoing to json format before persisting data to the user defaults
//        autosave = $storedThemes.sink { themes in
//            let jsonData = try! JSONEncoder().encode(themes)
//            UserDefaults.standard.set(jsonData, forKey: defaultsKey)
//        }
//    }
//    
////    func addThemesToTheGame() {
////        for item in EmojiTheme.allCases {
////            storedThemes.append(item.theme)
////        }
////    }
//    
//    // adding new theme Untitled with default emojis
//    public func addNewTheme(named name: String = "Untitled") {
//        storedThemes.append(theme(topic: name, emojis: ["🐼","🐔","🦁", "🐙", "🐉", "🐌"],
//                                  cardsToShow : 6, color: UIColor.blue.rgb, id : storedThemes.count))
//    }
//    
////    public func removeTheme(_ theme: theme) {
////        storedThemes = storedThemes.filter { $0 != theme }
////    }
////
////    public func renameTheme(_ theme: theme, to newName: String) {
////        if let index = storedThemes.firstIndex(where: {$0 == theme}) {
////            storedThemes[index].name = newName
////        }
////    }
////
////    public func addEmoji(_ emoji: String, to theme:theme) {
////        if let index = storedThemes.firstIndex(where: {$0 == theme}) {
////            for item in Array(emoji) {
////                let trimmedEmoji = String(item).trimmingCharacters(in: .whitespaces)
////                if !storedThemes[index].content.contains(trimmedEmoji), trimmedEmoji != "" {
////                    storedThemes[index].content.append(trimmedEmoji)
////                }
////            }
////        }
////    }
////
////    public func removeEmoji(_ emoji: String, from theme:theme) {
////        if let index = storedThemes.firstIndex(where: {$0 == theme}), theme.isAllowedToRemojeEmoji() {
////            storedThemes[index].content = storedThemes[index].content.filter { $0 != emoji }
////        }
////    }
////
////    public func inreaseNumberOfCards(for theme: theme) {
////        if let index = storedThemes.firstIndex(where: {$0 == theme}), theme.content.count > theme.numberOfCards {
////            storedThemes[index].numberOfCards += 1
////        }
////    }
////
////    public func decreaseNumberOfCards(for theme: theme) {
////        if let index = storedThemes.firstIndex(where: {$0 == theme}), theme.numberOfCards > 4 {
////            storedThemes[index].numberOfCards -= 1
////        }
////    }
////
////    public func changeThemeColor(_ color:Color, for theme: theme) {
////        if let index = storedThemes.firstIndex(where: {$0 == theme}) {
////            storedThemes[index].rgbColor = UIColor(color).rgb
////        }
////    }
//}
