//
// Created by Isaac Royo Raso on 13/1/21.
//

import Foundation

func getPhotos(_ completeWith: @escaping (Output<PhotoPair>) -> Void) {
    NetworkManager<PexelsPhotoList>().request("search", params: [
        "orientation": "landscape",
        "page": String(Int.random(in: 0...1000)),
        "query": "nature",
        "per_page": "2",
    ], headers: [
        "Authorization": Constants.PEXELS_KEY
    ]) { output in
        completeWith(output.map { response in
            let photos = response.result.photos
            if  !photos.isEmpty {
                return PhotoPair(photos.map { photo in photo.convert() }, origin: .pexels)
            } else {
                throw NetworkError.emptyResponse
            }
        })

    }
}
