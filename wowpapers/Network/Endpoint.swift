//
// Created by Isaac Royo Raso on 3/2/21.
//

import Foundation

protocol Endpoint {

    static var baseURL: String { get }
    static var headers: [String: Any] { get }

}

extension Endpoint {

    static var headers: [String: Any] {
        [String: String]()
    }

    static func buildRequest(
        path: String,
        params: [String: String] = [String: String]()
    ) -> URLRequest {
        var components = URLComponents(string: baseURL + path)!
        components.queryItems = params.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        var request = URLRequest(url: components.url!)
        headers.forEach { key, value in
            if let value = value as? String {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        return request
    }

}
