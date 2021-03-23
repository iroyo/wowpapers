//
//  NetworkManager.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 13/1/21.
//

import Combine
import Foundation

typealias NetworkPublisher<T> = AnyPublisher<NetworkResponse<T>, Error>

extension HTTPURLResponse {

    var isSuccessful: Bool {
        (200...299).contains(statusCode)
    }
}

struct NetworkManager<T: Encodable> {

    private let decoder = JSONDecoder()
    private let method: HTTPMethod<T>
    private let headers: Headers
    private let params: Params
    private let url: String

    init(
        _ method: HTTPMethod<T> = .get,
        headers: Headers = Headers(),
        params: Params = Params(),
        url: String
    ) {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        self.method = method
        self.headers = headers
        self.params = params
        self.url = url
    }

    func run<R: Decodable>() -> NetworkPublisher<R> {
        let request: URLRequest
        do {
            request = try buildRequest()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
        let started = Date()
        
        if let url = request.url {
            print(url.absoluteString)
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { (data: Data, response: URLResponse) -> NetworkResponse<R> in
                guard let response = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse()
                }
                guard response.isSuccessful else {
                    throw NetworkError.invalidResponse(response.statusCode)
                }
                let interval = Date().timeIntervalSince(started)
                let result = try decoder.decode(R.self, from: data)
                return NetworkResponse(result, interval, response.allHeaderFields)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    private func addQueryParams(to url: URL) -> URL {
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            var queryItems = [URLQueryItem]()
            params.forEach { key, value in
                if let value = value as? String {
                    queryItems.append(URLQueryItem(name: key, value: value))
                }
            }
            urlComponents.queryItems = queryItems
            return urlComponents.url ?? url
        }
        return url
    }

    private func buildRequest() throws -> URLRequest {
        guard let url = URL(string: url) else {
            throw NetworkError.invalidURL
        }

        let resultURL = addQueryParams(to: url)
        var request = URLRequest(url: resultURL)
        request.httpMethod = method.name

        if let body = method.body {
            let encoder = JSONEncoder()
            do {
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = try encoder.encode(body)
            } catch {
                throw NetworkError.invalidBody
            }
        }

        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        return request
    }

}
