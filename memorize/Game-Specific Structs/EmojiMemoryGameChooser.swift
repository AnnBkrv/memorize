////
////  EmojiMemoryGameChooser.swift
////  Memorize
////
////  Created by Marlen Mynzhassar on 10/18/20.
////  Copyright © 2020 Marlen Mynzhassar. All rights reserved.
////
//
//import SwiftUI
//
//struct EmojiMemoryGameChooser: View {
//    
//    @EnvironmentObject var store: EmojiMemoryGameStore
//    @State private var editMode: EditMode = .inactive
//    
//    var body: some View {
//        VStack {
//            NavigationView {
//                List{
//                    ForEach(store.setOfThemes) { theme in
////                        here we start a new game with the theme from the list. we navigate to the game view
//                        NavigationLink(destination: EmojiMemoryGameView(ViewModel: EmojiMemoryGame())
//                                        .navigationBarTitle(theme.topic)
//                        ) {
//                            ThemeView(theme: theme, editMode: $editMode)
//                                .environmentObject(store)
//                        }
//                    }.onDelete { indexSet in
//                        indexSet.map { self.store.storedThemes[$0] }.forEach { theme in
//                            store.removeTheme(theme)
//                        }
//                    }
//                }
//                .navigationBarTitle(store.name, displayMode: .inline)
//                .navigationBarItems(
//                    leading: Button(action: {
//                        withAnimation {
//                            store.addNewTheme()
//                        }
//                    }, label: {
//                        Image(systemName: "plus").imageScale(.large)
//                    }),
//                    trailing: EditButton()
//                )
//                .environment(\.editMode, $editMode)
//            }
//        }
//    }
//}
