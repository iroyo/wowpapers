//
// Created by Isaac Royo Raso on 13/1/21.
//

import Combine
import Foundation

enum PexelsApi: Endpoint {

    private static let headers = ["Authorization": Constants.PEXELS_KEY]
    private static var defaultParams = ["orientation": "landscape"]
    private static var page: String {
        String(Int.random(in: 1...100))
    }

    static var networkClient = NetworkClient(baseURL: "https://api.pexels.com", headers: headers)

    static func searchRandomPhotoPair(query: String) -> NetworkPublisher<PexelsPhotoList> {
        makeRequest(to: "/v1/search", params: defaultParams.plus([
            "per_page": "2",
            "query": query,
            "page": page
        ]))
    }
}

