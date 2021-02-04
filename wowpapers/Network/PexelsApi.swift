//
// Created by Isaac Royo Raso on 13/1/21.
//

import Combine
import Foundation

enum PexelsApi: Endpoint {

    private static let networkManager = NetworkManager()

    static var baseURL: String = "https://api.pexels.com/v1/"
    static var headers: [String: Any] = ["Authorization": Constants.PEXELS_KEY]

    private static var params = [
        "orientation": "landscape",
        "per_page": "2",
    ]

    static func photos(query: String) -> AnyPublisher<PexelsPhotoList, Error> {
        params["query"] = query
        params["page"] = String(Int.random(in: 0...100))
        let request = buildRequest(path: "search", params: params)
        return networkManager.execute(request).unwrap()
    }
}

