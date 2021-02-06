//
// Created by Isaac Royo Raso on 5/2/21.
//

import Combine
import Foundation

struct PexelsPhotoRepository: PhotoRepository {

    func getPhotosFrom(category: String) -> AnyPublisher<[Photo], Error> {
        PexelsApi.searchRandomPhotoPair(query: category)
            .result()
            .map(\.photos)
            .map { photos in
                photos.map { photo in
                    photo.convert()
                }
            }.eraseToAnyPublisher()
    }


}