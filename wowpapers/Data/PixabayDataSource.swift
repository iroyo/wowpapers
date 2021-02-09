//
// Created by Isaac Royo Raso on 5/2/21.
//

import Combine
import Foundation

struct PixabayDataSource: PhotoDataSource {

    func getPhotos(from category: String) -> AnyPublisher<[Photo], Error> {
        PixabayApi.searchRandomPhotos(query: category).result()
            .map(\.hits)
            .convert()
    }

}