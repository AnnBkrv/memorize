//
//  buttonStyle.swift
//  memorize
//
//  Created by Anna Bukreeva on 03.11.20.
//

import SwiftUI

struct buttonStyle: ButtonStyle {
    
    var bgColor: Color
    
    func makeBody(configuration : Self.Configuration) -> some View{
        configuration.label
    }
}

