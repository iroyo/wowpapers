//
// Created by Isaac Royo Raso on 13/1/21.
//

import Combine
import Foundation

enum PixabayApi: Endpoint {

    private static var defaultParams = [
        "key" : Constants.PIXABAY_KEY,
        "orientation": "horizontal",
        "image_type": "photo"
    ]
    static var networkClient = NetworkClient(baseURL: "https://pixabay.com")

    static func searchPhotos(query: String, _ offset: Int, _ limit: Int = 2) -> NetworkPublisher<PixabayPhotoList> {
        makeRequest(to: "/api/", params: defaultParams.plus([
            "per_page": String(limit),
            "page": String(offset),
            "q": query,
        ]))
    }
}

