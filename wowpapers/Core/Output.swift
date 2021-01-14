//
//  Output.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 13/1/21.
//

import Foundation

enum Output<T> {
    case success(T)
    case error(Error)

    func map<C>(_ convert: (T) throws -> C) -> Output<C> {
        switch self {
        case .success(let result):
            do {
                return try .success(convert(result))
            } catch {
                return .error(error)
            }
        case .error(let problem):
            return .error(problem)
        }
    }
}
