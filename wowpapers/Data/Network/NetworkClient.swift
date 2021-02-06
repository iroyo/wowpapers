//
// Created by Isaac Royo Raso on 6/2/21.
//

import Foundation

struct NetworkClient {

    let baseURL: String
    let headers: [String: String]

    init(baseURL: String, headers: [String: String] = [String: String]()) {
        self.baseURL = baseURL
        self.headers = headers
    }

    private func request<T : Encodable>(_ method: HTTPMethod<T>, _ route: String, params: Params) -> NetworkManager<T> {
        NetworkManager(
            method,
            headers: headers,
            params: params,
            url: baseURL + route
        )
    }

    func execute<T : Encodable, R: Decodable>(_ method: HTTPMethod<T>, _ route: String, params: Params = Params()) -> NetworkPublisher<R> {
        request(method, route, params: params).run()
    }

}
