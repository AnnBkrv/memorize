//
//  themeView.swift
//  memorize
//
//  Created by Anna Bukreeva on 26.10.20.
//

import SwiftUI

struct ThemeView: View {
    var theme: Theme
    @Binding var showThemeEditor: Bool
    @State private var themeName: String = ""
    @State private var emojiToAdd = ""
    
    @EnvironmentObject var store: EmojiMemoryGameStore
    
    var body: some View {
        VStack(spacing:0) {
            ZStack {
                Text("Theme Editor").font(.headline).padding()
                HStack {
                    Spacer()
                    Button(action: {
                        showThemeEditor = false
                    }) { Text("Done").foregroundColor(.blue).padding() }
                }
            }
            Divider()
            Form {
                Section() {
                    TextField(theme.topic, text: $themeName, onEditingChanged: { began in
                        if !began {
                            store.changeName(newName: themeName, theme: theme)
                        }
                    })
                }
//                Section(header: Text("Add emoji")) {
//                    HStack {
//                        TextField("Emoji", text: $emojiToAdd)
//                        Spacer()
//                        Button(action: {
//                            store.addEmoji(emojiToAdd, theme: theme)
//                            emojiToAdd = ""
//                        }) { Text("Add").foregroundColor(.blue) }
//                    }
//                }
        }
    }
}
}
