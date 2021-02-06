//
// Created by Isaac Royo Raso on 5/2/21.
//

import Combine
import Foundation

enum ProviderType {
    case pexels
}

protocol PhotoProvider {

    func searchPhotoPair(from category: String) -> AnyPublisher<PhotoModel, Error>

}

struct PhotoManager: PhotoProvider {

    private let pexelsProvider = PexelsDataSource()

    private var providerType: ProviderType {
        .pexels
    }

    private var provider: (String) -> AnyPublisher<[Photo], Error> {
        switch providerType {
        case .pexels: return pexelsProvider.getPhotos
        }
    }

    func searchPhotoPair(from category: String) -> AnyPublisher<PhotoModel, Error> {
        provider(category).map { photos in
            PhotoPair(photos)
        }.flatMap { pair in
            Publishers.Zip(
                getPhotoData(url: pair.top.thumbnailSrc),
                getPhotoData(url: pair.bottom.thumbnailSrc)
            ).map { topURL, bottomURL in
                PhotoModel(pair, topURL, bottomURL)
            }
        }.eraseToAnyPublisher()
    }

    func getPhotoData(url: String) -> AnyPublisher<Data, Error> {
        guard let url = URL(string: url) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in data }
            .eraseToAnyPublisher()
    }


}