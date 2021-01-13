//
//  Output.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 13/1/21.
//

import Foundation

enum Output<T> {
    case error(Error)
    case success(T)
}
