//
//  color_extension.swift
//  EmojiArt
//
//  Created by Anna Bukreeva on 12.10.20.
//  Copyright © 2020 CS193p Instructor. All rights reserved.
//
// Lecture 9 probably? what the hell is this and where did it come from?

import SwiftUI

extension Color {
 init(_ rgb: UIColor.RGB) {
    self.init(UIColor(rgb))
    }
}
extension UIColor {
    public struct RGB: Hashable, Codable {
        var red: CGFloat
        var green: CGFloat
        var blue: CGFloat
        var alpha: CGFloat
    }

     convenience init(_ rgb: RGB) {
     self.init(red: rgb.red, green: rgb.green, blue: rgb.blue, alpha: rgb.alpha)
     }

 public var rgb: RGB {
     var red: CGFloat = 0
     var green: CGFloat = 0
     var blue: CGFloat = 0
     var alpha: CGFloat = 0
     getRed(&red, green: &green, blue: &blue, alpha: &alpha)
     return RGB(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension Data {
    // just a simple converter from a Data to a String
    var utf8: String? { String(data: self, encoding: .utf8 ) }
}
