//
//  cardify.swift
//  memorize
//
//  Created by Anna Bukreeva on 29.09.20.
//

import SwiftUI


struct Cardify : AnimatableModifier {
    
    var rotation: Double
    
    var animatableData: Double{
        get {rotation}
        set {rotation = newValue}
    }
    
    var isFaceUp : Bool{
        rotation < 90
    }
    
    init(isFaceUp : Bool){
        rotation = isFaceUp ? 0 : 180 // if the card is face up, rotation is set to 0, otherwise to 180
    }
    
    func body(content:Content) -> some View {
        ZStack {
            Group{
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)//.padding()
                content
            }.opacity(isFaceUp ? 1 : 0) // the views are displayed at the same time. when the card is face down, you can't see the three things above because their opacity is set to 0
            RoundedRectangle(cornerRadius: cornerRadius).fill()
                        .padding(4).opacity(isFaceUp ? 0 : 1)
            //doesn't draw anything if the card is matched. makes an empty view
            }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0)) // turns the card face up
//        shouldn't this apply rotation to the whole z-stack?
        
    }

 
    private let cornerRadius : CGFloat = 10
    private let edgeLineWidth: CGFloat = 3
    private let fontScaleFactor: CGFloat = 0.75
}

extension View {
    func cardify(isFaceUp : Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
