//
//  UnsplashApi.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 1/4/21.
//

import Combine
import Foundation

enum UnsplashApi: Endpoint {

    private static let headers = ["Authorization": "Client-ID \(Constants.UNSPLASH_KEY)" ]
    private static var defaultParams = ["orientation": "landscape"]

    static var networkClient = NetworkClient(baseURL: "https://api.unsplash.com", headers: headers)

    static func searchPhotos(query: String, _ limit: Int = 2) -> NetworkPublisher<[UnsplashPhoto]> {
        makeRequest(to: "/photos/random", params: defaultParams.plus([
            "count": String(limit),
            "query": query
        ]))
    }
}
