//
//  Grid.swift
//  memorize
//
//  Created by Anna Bukreeva on 28.09.20.
//

import SwiftUI

extension Grid where Item:Identifiable, ID == Item.ID {
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.init(items, id: \Item.id, viewForItem: viewForItem)
    }
}

struct Grid<Item, ID, ItemView>: View where ID : Hashable, ItemView: View{
    
    var items : [Item]
    private var id: KeyPath<Item,ID>
    var viewForItem : (Item) -> ItemView //  a function that returns an item view for each item passed to it
    
    init(_ items: [Item], id: KeyPath<Item,ID>, viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.id = id
        self.viewForItem = viewForItem
    }
//    @escaping is added because Item is not used or initialied in this initializer, it's called later
    var body: some View {
        GeometryReader {geometry in
            self.body(for: GridLayout(itemCount: items.count, in: geometry.size))
        }
    }
    
    func body(for layout: GridLayout) -> some View {
        ForEach(items, id:id) { item in
            self.body(for: item, in: layout)
        }
    }
    
    func body(for item: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(where: { item[keyPath: id] == $0[keyPath: id] } )
        return viewForItem(item)
                    .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                    .position(layout.location(ofItemAt: index!))
    }
    
}

//struct Grid_Previews: PreviewProvider {
//    static var previews: some View {
//        Grid()
//    }
//}
