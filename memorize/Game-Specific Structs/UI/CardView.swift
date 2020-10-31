//
//  CardView.swift
//  memorize
//
//  Created by Anna Bukreeva on 05.10.20.
//

import SwiftUI

//this defines how one card is displayed. i.e. the emoji on a rectangle or a rectangle

struct CardView: View {
    
    var card: MemoryGame<String>.Card

    var body: some View{
        GeometryReader { geometry in
            self.body(for: geometry.size) // arranges the elements in the body function using the Geometry Reader
        }
    }
    
    @State private var animatedBonusRemaining : Double = 0
    
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration : card.bonusTimeRemaining)){
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View{
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group{
                    if card.isConsumingBonusTime{
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90))
                            .onAppear {
                                self.startBonusTimeAnimation()
                            }
                    }
                    else{
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90))
                    }
                }.padding(5).opacity(0.4).transition(.identity)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
//                    all the animations for matching or not matching
                    
                    .rotationEffect(Angle.degrees(card.isMatched ? 360:0)) // this alone makes the emoji turn 360 degrees if the card is matched. to animate this change you need the fct below
                    .animation(card.isMatched ?
                                Animation.linear(duration: 1).repeatForever(autoreverses: false): // if the card is matched
                                .default)
//                    card didn't get matched:
                    .saturation(card.didntGetMatchedInThisRound ? 0: 1)
                    .animation(card.didntGetMatchedInThisRound ?
                                Animation.linear(duration: 0.3).repeatForever():
                                .default)
                    .rotationEffect(Angle.degrees(card.didntGetMatchedInThisRound ? 60:0))
                    .animation(card.didntGetMatchedInThisRound ?
                                Animation.linear(duration: 0.3).repeatCount(5):
                                .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale) // not sure what this does
        }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
    
//    MARK: - Drawing constants
    private let fontScaleFactor: CGFloat = 0.75
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}
