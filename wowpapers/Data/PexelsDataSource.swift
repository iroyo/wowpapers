//
// Created by Isaac Royo Raso on 5/2/21.
//

import Combine
import Foundation

struct PexelsDataSource: PhotoDataSource {

    func getPhotosFrom(category: String) -> AnyPublisher<[Photo], Error> {
        PexelsApi.searchRandomPhotoPair(query: category).result()
            .map(\.photos)
            .convert()
    }


}