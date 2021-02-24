//
// Created by Isaac Royo Raso on 13/1/21.
//

import Combine
import Foundation

enum PixabayApi: Endpoint {

    private static var defaultParams = [
        "key" : Constants.PIXABAY_KEY,
        "orientation": "landscape",
        "image_type": "photo"
    ]
    private static var page: String {
        String(Int.random(in: 0...100))
    }

    static var networkClient = NetworkClient(baseURL: "https://pixabay.com")

    static func searchRandomPhotos(query: String) -> NetworkPublisher<PixabayPhotoList> {
        makeRequest(to: "/api/", params: defaultParams.plus([
            "per_page": "3",
            "page": page,
            "q": query,
        ]))
    }
}

