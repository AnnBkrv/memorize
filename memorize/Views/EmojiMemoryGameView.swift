//
//  ContentView.swift
//  memorize
// the view of the game
//  Created by Anna Bukreeva on 26.09.20.
//

import SwiftUI


struct EmojiMemoryGameView: View {
    @ObservedObject var ViewModel: EmojiMemoryGame
    @State var explainNoMoreEmojis = false
    @EnvironmentObject var store : EmojiMemoryGameStore
    
    var body: some View {
        VStack{
            HStack{
                ThemeChooser(ViewModel: ViewModel)
                Spacer()
                Text("Your Score: \(ViewModel.score)")
                    .font(Font.largeTitle)
                Spacer()
                Button("New game") {
                    withAnimation(Animation.easeInOut(duration: 1)){
                        ViewModel.newGame(gameTheme : store.setOfThemes.randomElement()!)}
                }
            }.padding([.leading, .trailing, .top])
            Grid(ViewModel.cards) { card in
                    CardView(card:card).aspectRatio(2/3, contentMode: .fit).onTapGesture {
                        withAnimation(.linear)
                        {
                            ViewModel.choose(card: card)}
                    }
                }
            .foregroundColor(Color(ViewModel.colorTheme))
            .padding(13)
            .background(Color.black)
            Button("Deal more"){
                withAnimation(Animation.easeInOut(duration: 1)){
                    ViewModel.dealMore()
                    if (ViewModel.explainNoMoreEmojisToAdd){
                        explainNoMoreEmojis = true
                    }
                }
                
            }.padding(5)
            .alert(isPresented: $explainNoMoreEmojis) {
                Alert(title: Text("No More Cards To Add"),
                             message: Text("All emojis in this theme have been played. Add more to the theme or start a new game."),
                             dismissButton: .default(Text("OK")){
                                explainNoMoreEmojis = false
                             })
            }
        }
        
    }
}

//we can't declare vars in H or Zstacks
//var body also can't be used

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game  = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(ViewModel: EmojiMemoryGame())
    }
}

