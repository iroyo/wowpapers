//
// Created by Isaac Royo Raso on 13/1/21.
//

import Combine
import Foundation

enum PexelsApi: Endpoint {

    private static let headers = ["Authorization": Constants.PEXELS_KEY]
    private static var defaultParams = ["orientation": "landscape"]

    static var networkClient = NetworkClient(baseURL: "https://api.pexels.com", headers: headers)

    static func searchPhotos(query: String, _ offset: Int, _ limit: Int = 2) -> NetworkPublisher<PexelsPhotoList> {
        makeRequest(to: "/v1/search", params: defaultParams.plus([
            "per_page": String(limit),
            "page": String(offset),
            "query": query
        ]))
    }
}

