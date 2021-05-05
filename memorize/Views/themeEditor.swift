//
//  themeView.swift
//  memorize
//
//  Created by Anna Bukreeva on 26.10.20.
//

import SwiftUI

struct ThemeEditor: View {
    
    var theme: Theme
    @Binding var showThemeEditor: Bool
    @State private var themeName: String = ""
    @State private var emojiToAdd = ""
    @State private var selectedColor: Color = Color.black
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
                Section(header: Text("Add emoji")) {
                    HStack {
                        TextField("Emoji", text: $emojiToAdd)
                        Spacer()
                        Button(action: {
                            store.addEmoji(emojiToAdd, theme: theme)
                            emojiToAdd = ""
                        }) { Text("Add").foregroundColor(.blue) }
                    }
                }
                Section(header:
                            HStack {
                                Text("Emojis")
                                Spacer()
                                Text("tap emoji to exclude").font(.system(size: 10)).textCase(.lowercase)
                            },
                        footer: theme.isAllowedToRemoveEmoji() ? Text("") : Text("Emoji can't be deleted. Minimum number: \(theme.cardsToShow!)")
                ) {
                    Grid(theme.emojis, id: \.self ) { emoji in
                        Text(emoji)
                            .font(Font.system(size: 40))
                            .onTapGesture() {
                                store.removeEmoji(emoji, from: theme)
                            }
                    }.frame(height:CGFloat((theme.emojis.count - 1) / 6) * 70 + 70)
                    
                }.environmentObject(store)
                Section(header: Text("Color")) {
                    ColorPicker (
                        "Pick a color",
                        selection: $selectedColor
                    )//.foregroundColor(selectedColor) => idk what this does
                    .onChange(of: selectedColor, perform: { value in // Adds a modifier for this view that fires an action when a specific value changes. idk why it goes value in instead of just calling the fct. we don't use the value variable anywhere
                        store.changeColor(selectedColor, theme: theme)
                    })
                }
                Section(header: Text("Card Count")) {
                    HStack {
                        Text("\(theme.cardsToShow!) Pairs")
                        Spacer()
                        Stepper(onIncrement: {
                            store.increaseCardNumber(for: theme)
                        }, onDecrement: {
                            store.decreaseCardNumber(for: theme)
                        }, label: { EmptyView() })
                    }
                }
        }
    }.onAppear {
//        themeName = theme.name
        selectedColor = Color(theme.color)
    }
}
}
