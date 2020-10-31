//
//  array+identifiable.swift
//  memorize
//
//  Created by Anna Bukreeva on 28.09.20.
//

import Foundation

extension Array where Element: Identifiable{
//    var only : Element?{
//        count == 1 ? first : nil
////        if count equals 1, return first, i.e. the first item in the array, otherwise return nil
//    }
    func firstIndex(matching: Element) -> Int?{
        for index in 0..<self.count{
            if self[index].id == matching.id {
                return index 
            }
        }
        return nil
    }
    
}
