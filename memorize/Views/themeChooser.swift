//
//  themeChooser.swift
//  memorize
//
//  Created by Anna Bukreeva on 16.10.20.
//

import SwiftUI

struct themeChooser: View {

    @ObservedObject var ViewModel: EmojiMemoryGame
    @State private var showChooser = false
    
    var body: some View {
        Text(ViewModel.nameTheme)
            .font(Font.title)
            .onTapGesture {
                showChooser = true
            }
            .sheet(isPresented: $showChooser) {
                ThemeEditor(isShowing: $showChooser)
                    .frame(minWidth: 300, minHeight: 500)
                    .environmentObject(ViewModel)
            }
    }
    
}



struct ThemeEditor : View {
    @Binding var isShowing : Bool
    @EnvironmentObject var ViewModel: EmojiMemoryGame
    @State private var editMode : EditMode = .inactive
    @State private var showThemeEditor = false
    
    
    @EnvironmentObject var store: EmojiMemoryGameStore
    
    var body: some View {
            HStack {
                Button(action: {editMode = .active}, label: {Text("Edit")}).padding()
                Spacer()
                Button(action: {isShowing = false}, label: {Text("Done")}).padding()
            }
            Text("Theme Editor").font(.headline).padding()
//            Divider()
            List{
                ForEach(store.setOfThemes) { gameTheme in
                        VStack {
                            HStack {
                                Text(gameTheme.topic)
                                    .foregroundColor(Color(gameTheme.color))
                                Spacer()}
                            HStack {
                                Text("\(gameTheme.cardsToShow!) pairs from \(gameTheme.emojis.joined())")
                                Spacer()
                            }
                            .onTapGesture {
                                if editMode == .active // how do i get all these red minus signs in the left corner
                                {   print("tapped")
                                    showThemeEditor = true} // tap the theme and make it take me to the theme view
                                else{
                                    print("edit mode inactive")
                                    ViewModel.newGame(gameTheme : gameTheme)
                                    isShowing = false
                                }
                            }
                            .sheet(isPresented: $showThemeEditor, onDismiss: {
                                editMode = EditMode.inactive
                                print("\(gameTheme.topic)")
                            }){
                                ThemeView(theme: gameTheme, showThemeEditor: $showThemeEditor)
                            }
                    }
        }
//            .environment(\.editMode, $editMode) // what does this do????
        }
    }
}

