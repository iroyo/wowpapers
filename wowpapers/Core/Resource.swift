//
// Created by Isaac Royo Raso on 8/2/21.
//

import Foundation

enum Resource<T> {
    case waiting
    case loaded(T)
    case failed(Error)
}

extension Resource {

    func map<V>(_ transform: (T) throws -> V) -> Resource<V> {
        do {
            switch self {
            case .waiting: return .waiting
            case let .failed(error): return .failed(error)
            case let .loaded(value): return .loaded(try transform(value))
            }
        } catch {
            return .failed(error)
        }
    }

}
