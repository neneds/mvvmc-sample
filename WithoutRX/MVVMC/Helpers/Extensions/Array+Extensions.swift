
//
//  Array+Extensions.swift
//  MVVMC
//
//  Created by Dennis Merli Rodrigues on 02/07/18.
//  Copyright © 2018 Dennis Merli. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {

    @discardableResult mutating func remove(object: Element) -> Bool {
        if let index = index(of: object) {
            self.remove(at: index)
            return true
        }
        return false
    }

    @discardableResult mutating func remove(where predicate: (Array.Iterator.Element) -> Bool) -> Bool {
        if let index = self.index(where: { (element) -> Bool in
            return predicate(element)
        }) {
            self.remove(at: index)
            return true
        }
        return false
    }

}
