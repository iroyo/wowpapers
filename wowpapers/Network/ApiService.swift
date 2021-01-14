//
// Created by Isaac Royo Raso on 13/1/21.
//

import Foundation

func getPhotos(_ completeWith: @escaping (Output<PhotoProvider>) -> Void) {
    NetworkManager<PexelsPhotoList>().request("search", params: [
        "orientation": "landscape",
        "page": String(Int.random(in: 0...1000)),
        "query": "nature",
        "per_page": "1",
    ], headers: [
        "Authorization": Constants.PEXELS_KEY
    ]) { output in
        completeWith(output.map { response in
            if let photo = response.result.photos.first {
                return .external(photo.convert())
            } else {
                throw NetworkError.invalidURL
            }
        })

    }
}
