//
//  NetworkManager.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 13/1/21.
//

import Foundation

extension HTTPURLResponse {

    var isSuccessful: Bool {
        get {
            (200...299).contains(statusCode)
        }
    }
}

struct NetworkManager<T: Decodable> {

    private let decoder = JSONDecoder()
    private let BASE_URL = "https://api.pexels.com/v1/"

    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func makeRequest(
            _ url: String,
            params: [String: String] = [String: String](),
            headers: [String: String] = [String: String](),
            completeWith: @escaping (Output<T>) -> Void
    ) {

        func abortBecause(_ problem: NetworkError) {
            completeWith(.error(problem))
        }

        guard var components = URLComponents(string: BASE_URL + url) else {
            return abortBecause(.invalidURL)
        }

        components.queryItems = params.map { key, value in
            URLQueryItem(name: key, value: value)
        }

        guard let url = components.url else {
            return abortBecause(.invalidURL)
        }

        var request = URLRequest(url: url)
        headers.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) -> () in
            if let response = response as? HTTPURLResponse {
                guard let data = data, response.isSuccessful else {
                    return abortBecause(.invalidResponse(response.statusCode))
                }
                do {
                    let result = try decoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completeWith(.success(result))
                    }
                } catch let error {
                        completeWith(.error(error))
                }
            } else {
                abortBecause(.invalidResponse())
            }
        }
        task.resume()

    }

}
