//
// Created by Isaac Royo Raso on 6/2/21.
//

import Foundation

protocol Convertible {
    associatedtype Item

    func convert() -> Item
}
