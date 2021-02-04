//
//  NetworkManager.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 13/1/21.
//

import Combine
import Foundation

extension HTTPURLResponse {

    var isSuccessful: Bool {
        (200...299).contains(statusCode)
    }
}

extension Publisher {

    func unwrap<T>() -> AnyPublisher<T, Error>
        where Output == NetworkResponse<T>, Failure == Error {
        map { response -> T in response.result }.eraseToAnyPublisher()
    }
}

struct NetworkManager {

    private let decoder = JSONDecoder()

    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func execute<T: Decodable>(_ request: URLRequest) -> AnyPublisher<NetworkResponse<T>, Error> {
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { (data: Data, response: URLResponse) -> NetworkResponse<T> in
                print(data)
                guard let response = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse()
                }
                guard response.isSuccessful else {
                    throw NetworkError.invalidResponse(response.statusCode)
                }
                let result = try decoder.decode(T.self, from: data)
                return NetworkResponse(result, response.allHeaderFields)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

}
