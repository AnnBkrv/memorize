//
//  EmojiTheme.swift
//  Memorize
//
//  Created by Marlen Mynzhassar on 10/11/20.
//  Copyright © 2020 Marlen Mynzhassar. All rights reserved.
//

import SwiftUI

enum EmojiTheme: CaseIterable {
    
    case animals
    case halloween
    case gestures
    case nature
    case activities
    case myth
    case travel
    case cat_faces
    
    var theme: Theme {
        switch self {
        case .animals: return Theme(topic: "Animals", emojis: ["🐇", "🦜", "🐣", "🐠", "🐅", "🦂", "🐿"], cardsToShow: 6, color: UIColor.gray.rgb)

        case .halloween: return Theme(topic: "Halloween", emojis: ["👻", "🎃", "🕸", "😱", "☠️", "🧛🏻‍♂️", "🧟‍♂️"], cardsToShow: 6, color: UIColor.orange.rgb)
            
        case .gestures: return Theme(topic: "Gestures", emojis: ["👋","✌️","💪","🤞","🤙","🖖", "🙌", "🤝", "👊", "👌"], cardsToShow: 6, color: UIColor.purple.rgb)

        case .nature: return Theme(topic : "Nature", emojis : ["🌪", "🌊", "🔥", "🌴", "🍀", "🐚", "🌈"], cardsToShow : 6, color : UIColor.green.rgb)
            
        case .activities: return Theme(topic : "Activities", emojis : ["🥋", "🥊", "🤿", "🎹", "🎬", "🪁", "🎳", "🛹", "🏄🏻‍♂️", "♟"], cardsToShow : 6, color : UIColor.red.rgb)
            
        case .myth: return Theme(topic : "Mythical Creatures", emojis : ["🐉", "🐲", "🧜🏻‍♀️", "🧝🏻‍♀️", "🧞‍♂️", "🧛🏻‍♂️", "🧚🏿‍♀️"], cardsToShow : 6, color : UIColor.blue.rgb)

            
        case .travel: return Theme(topic : "Travel", emojis : ["🗽", "🗺", "🌋", "🌁", "🕌", "🏛", "🌆", "🗿", "⚓️", "🚂", "🛫"], cardsToShow : 6, color : UIColor.magenta.rgb)
            
        case .cat_faces: return Theme(topic : "Cat Faces", emojis : ["😺", "😹", "😼", "😽", "😸", "😻", "🙀"], cardsToShow : 6, color : UIColor.cyan.rgb)
        }

        
    }
}
