//
// Created by Isaac Royo Raso on 3/2/21.
//

import Foundation

protocol Endpoint {

    static var networkClient: NetworkClient { get }

}

extension Endpoint {

    static func makeRequest<T: Encodable, R: Decodable>(as method: HTTPMethod<T> = .get, to route: String, params: Params = Params()) -> NetworkPublisher<R> {
        networkClient.execute(method, route, params: params)
    }

    static func makeRequest<R: Decodable>(as method: HTTPMethod<Nothing> = .get, to route: String, params: Params = Params()) -> NetworkPublisher<R> {
        networkClient.execute(method, route, params: params)
    }

}
