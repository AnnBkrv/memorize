//
//  array+only.swift
//  memorize
//
//  Created by Anna Bukreeva on 28.09.20.
//

import Foundation

extension Array {
    var only : Element?{
        count == 1 ? first : nil
//        if count equals 1, return first, i.e. the first item in the array, otherwise return nil
    }
}
