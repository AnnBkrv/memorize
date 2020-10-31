//
//  memorizeTheme.swift
//  memorize
//
//  Created by Anna Bukreeva on 29.09.20.
//

import SwiftUI
import Combine

struct Theme : Identifiable, Codable, Equatable { // Equatable protocol so i can use == operator
    
    var topic : String
    var emojis : [String]
    var cardsToShow : Int?
    var color : UIColor.RGB // color needs to be encodable
    var id: UUID
        
    mutating func selfChangeName(name: String){
        self.topic = name
    }
    
    var json: Data? {
        try? JSONEncoder().encode(self)
        
    }
    
    init (topic:String, emojis:[String], cardsToShow:Int, color: UIColor.RGB, id: UUID? = nil) {
        self.id = id ?? UUID()
        self.topic = topic
        self.emojis = emojis
        self.cardsToShow = cardsToShow
        self.color = color
    }
    
}

class EmojiMemoryGameStore : ObservableObject {
//    @Published var setOfThemes : [theme] {
//        get{
//            [emojis_set_one, emojis_set_two, emojis_set_three, emojis_set_four, emojis_set_five, emojis_set_six]}
//        set {
////                setOfThemes = newValue
//            }
//    } // when you use this syntax, you are setting your variable with only the getter. there is no setter. so now you can't change this variable

    @Published var setOfThemes = [Theme]()
    private var autosave: AnyCancellable? //publisher to emit changes

    init(named name: String = "Memorize") {
        let defaultsKey = "EmojiMemoryGame.\(name)"
        let data = UserDefaults.standard.data(forKey: defaultsKey)
        if data != nil, let newStoredThemes = try? JSONDecoder().decode([Theme].self, from: data!) { // and THAT is how you decode data from stored user defaults. wtf, this is so complicated. what is [theme].self, why the self?
            setOfThemes = newStoredThemes
        } else {
            for item in EmojiTheme.allCases { // accessing all items in an enum
                setOfThemes.append(item.theme)
            }
        }
        autosave = $setOfThemes.sink { themes in // sink -> do this when the publisher changes. sink is a subscriber to the publisher. the publisher is any var with $ in front of it, timer's publish(every:), NotificationCenter's publisher(for:)...
            let jsonData = try! JSONEncoder().encode(themes)
            UserDefaults.standard.set(jsonData, forKey: defaultsKey)
        }
    }
//    this makes an autosave upon initialization. this autosave is subscribed to the setOfThemes variable. anytime it changes, autosave changes too because it's SUBSCRIBED to the value. it updates automatically. neat-o.
    
    func changeName(newName: String, theme : Theme){
        if let index = setOfThemes.firstIndex(where: {$0 == theme}) {
            setOfThemes[index].topic = newName
        }
    }
    
    func addNewTheme(named name: String = "Untitled") {
        setOfThemes.append(Theme(topic: name, emojis: ["🐼","🐔","🦁", "🐙", "🐉", "🐌"],
                                  cardsToShow: 6, color: UIColor.blue.rgb))
    }
    
    func addEmoji(_ newEmojis: String, theme : Theme){
        if let index = setOfThemes.firstIndex(where: {$0 == theme}) {
            setOfThemes[index].emojis.append(contentsOf: [newEmojis]) //probably could do this with mapping somehow.
//            .onDelete{ indexSet in
//            indexSet.map { store.documents[$0]}.forEach { document in
//                store.removeDocument(document)
//            }
    }
    }
}
