//
//  themeChooser.swift
//  memorize
//
//  Created by Anna Bukreeva on 16.10.20.
//

import SwiftUI

struct ThemeChooser: View {

    @ObservedObject var ViewModel: EmojiMemoryGame
    @State private var showChooser = false
    @State private var showThemeEditor = false
//    @Binding var isShowing : Bool
    @EnvironmentObject var store: EmojiMemoryGameStore
    @State private var editMode : EditMode = .inactive
    
    var body: some View {
        Text(ViewModel.nameTheme)
            .font(Font.title)
            .onTapGesture {
                showChooser = true
            }.padding(10.0)
            .overlay(
                RoundedRectangle(cornerRadius: 10.0)
                    .stroke(lineWidth: 2.0)
            )
            .sheet(isPresented: $showChooser) {
                NavigationView{
                    List{
                        ForEach(store.setOfThemes) { gameTheme in
                                ThemeView(gameTheme : gameTheme, isShowing: $showChooser, editMode : $editMode)
//                                KEEP THIS!!!!!!!
//                                if editMode == .inactive{
//                                    Divider()
//                                    HStack{
//                                        Button(action: {
//                                            ViewModel.newGame(gameTheme : gameTheme)
//                                            showChooser = false
//                                        }, label: {Text("Play")}
//
//                                        )
//                                        .buttonStyle(PlainButtonStyle()) // because of THIS!!!!!
//                                            }
//                            }//.background(Color(gameTheme.color))
                        }
                        .onDelete { indexSet in
                            indexSet.map { store.setOfThemes[$0] }.forEach { theme in
                                store.removeTheme(theme) // lec 10, 1:29:00
//  https://www.youtube.com/watch?v=CKexGQuIO7E&list=PLpGHT1n4-mAtTj9oywMWoBx0dCGd51_yG&index=6&t=3905s

                            }}
                        //.environment(\.editMode, $editMode)
                    }.frame(minWidth: 300, minHeight: 500)
                    .environmentObject(ViewModel)
                    .navigationBarTitle("Theme View")
                    .navigationBarItems(leading: Button(action: {store.addNewTheme()
                        showThemeEditor = true
                    }
                                                        , label: {
                        Image(systemName: "plus").imageScale(.large)
                    })
                    .sheet(isPresented: $showThemeEditor, onDismiss: {
                        editMode = EditMode.inactive
                    }){
                        ThemeEditor(theme: store.setOfThemes.last!, showThemeEditor: $showThemeEditor)
                            .environmentObject(store)
                    }, trailing: EditButton())
                    .environment(\.editMode, $editMode)
            }//.environment(\.editMode, $editMode)
    }
    }
}



struct ThemeView : View {
    
    var gameTheme : Theme
    @Binding var isShowing : Bool
    @EnvironmentObject var ViewModel: EmojiMemoryGame
    @Binding var editMode : EditMode
    @State private var showThemeEditor = false
    @EnvironmentObject var store: EmojiMemoryGameStore

    var body: some View {
        HStack{
//            NavigationLink(destination:
//                        ThemeEditor(theme: gameTheme
//                                  , showThemeEditor: $showThemeEditor
//                        )
//                        .navigationBarTitle("Theme Editor")
//                        .navigationBarItems(trailing: Button(action: {isShowing = false}) { Text("Done").foregroundColor(.blue)})) {
            VStack {
            HStack {
                Text(gameTheme.topic)
                    .foregroundColor(Color(gameTheme.color))
                Spacer()}
            HStack {
                Text("\(gameTheme.cardsToShow!) pairs from \(gameTheme.emojis.joined())")
                Spacer()
            }}
            }
        //}.background(Color(.white))
        //.environment(\.editMode, $editMode)
            
//        }
            .onTapGesture{
                if editMode != .inactive
                { showThemeEditor = true }
                // tap the theme and make it take me to the theme view
                else {
                    ViewModel.newGame(gameTheme : gameTheme)
                    isShowing = false
                }
            }
            .sheet(isPresented: $showThemeEditor, onDismiss: {
                editMode = EditMode.inactive
            }){
                ThemeEditor(theme: gameTheme, showThemeEditor: $showThemeEditor)
            }
//        }
//            .environment(\.editMode, $editMode)
//        }
    }
    
}

