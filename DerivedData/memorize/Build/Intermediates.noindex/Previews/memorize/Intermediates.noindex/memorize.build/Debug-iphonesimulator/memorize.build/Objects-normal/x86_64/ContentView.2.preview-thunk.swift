@_private(sourceFile: "ContentView.swift") import memorize
import SwiftUI
import SwiftUI

extension ContentView_Previews {
    @_dynamicReplacement(for: previews) private static var __preview__previews: some View {
        #sourceLocation(file: "/Users/elenabukreeva/Documents/memorize/memorize/ContentView.swift", line: 53)
        AnyView(ContentView())
#sourceLocation()
    }
}

extension CardView {
    @_dynamicReplacement(for: body) private var __preview__body: some View {
        #sourceLocation(file: "/Users/elenabukreeva/Documents/memorize/memorize/ContentView.swift", line: 36)
        AnyView(ZStack {
            if isFaceUp{
                RoundedRectangle(cornerRadius: __designTimeFloat("#5439.[2].[1].property.[0].[0].arg[0].value.[0].[0].[0].arg[0].value", fallback: 20.0)).fill(Color.white)
                RoundedRectangle(cornerRadius: __designTimeFloat("#5439.[2].[1].property.[0].[0].arg[0].value.[0].[0].[1].arg[0].value", fallback: 20.0)).stroke(lineWidth: __designTimeInteger("#5439.[2].[1].property.[0].[0].arg[0].value.[0].[0].[1].modifier[0].arg[0].value", fallback: 3)).padding()
                Text(__designTimeString("#5439.[2].[1].property.[0].[0].arg[0].value.[0].[0].[2].arg[0].value.[0].value", fallback: "👻"))
            }
            else{
                RoundedRectangle(cornerRadius: __designTimeFloat("#5439.[2].[1].property.[0].[0].arg[0].value.[0].[1].[0].arg[0].value", fallback: 20.0)).fill()
            }
        })
#sourceLocation()
    }
}

extension ContentView {
    @_dynamicReplacement(for: body) private var __preview__body: some View {
        #sourceLocation(file: "/Users/elenabukreeva/Documents/memorize/memorize/ContentView.swift", line: 19)
//this value is computed, that's why the {} braces
        //        the type of body is any struct, as long as it behaves like a view
//        whenever  there's a one line fct that returns a value, you can leave out
//        the return fct and just type the value. to keep the code minimal
        AnyView(HStack{
            ForEach(0..<4) { index in
                CardView(isFaceUp: __designTimeBoolean("#5439.[1].[0].property.[0].[0].arg[0].value.[0].arg[1].value.[0].arg[0].value", fallback: false))
            }
        }
        .foregroundColor(Color.orange)
        .font(Font.largeTitle)
//            10 is like the font size
            .padding(__designTimeInteger("#5439.[1].[0].property.[0].[0].modifier[2].arg[0].value", fallback: 10)))
#sourceLocation()
    }
}

import struct memorize.ContentView
import struct memorize.CardView
import struct memorize.ContentView_Previews