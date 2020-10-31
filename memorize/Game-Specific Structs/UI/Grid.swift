//
//  Grid.swift
//  memorize
//
//  Created by Anna Bukreeva on 28.09.20.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item : Identifiable, ItemView: View{
    
    var items : [Item]
    var viewForItem : (Item) -> ItemView //  a function that returns an item view for each item passed to it
    
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
//    @escaping is added because Item is not used or initialied in this initializer, it's called later
    var body: some View {
        GeometryReader {geometry in
            self.body(for: GridLayout(itemCount: items.count, in: geometry.size))
        }
    }
    
//    var body : some View {
//        ForEach(items) { item in
//            self.viewForItem(item)
//        }
//    }
    
    func body(for layout: GridLayout) -> some View {
        ForEach(items) { item in
            self.body(for: item, in: layout)
        }
    }
    
    func body(for item: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(matching: item)!
        return viewForItem(item)
                    .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                    .position(layout.location(ofItemAt: index))
    }
    
}

//struct Grid_Previews: PreviewProvider {
//    static var previews: some View {
//        Grid()
//    }
//}
