//
// Created by Isaac Royo Raso on 5/2/21.
//

import Combine
import Foundation

typealias PhotoPair = (above: PhotoData, below: PhotoData)

enum ProviderType {
    case pexels
}

protocol PhotoProvider {

    func searchPhotoPair(from category: String) -> AnyPublisher<PhotoPair, Error>

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

    func searchPhotoPair(from category: String) -> AnyPublisher<PhotoPair, Error> {
        provider(category).flatMap { photos in
            Publishers.Zip(
                getPhotoData(url: photos[0].thumbnailSrc),
                getPhotoData(url: photos[1].thumbnailSrc)
            ).map { firstURL, secondURL in
                (
                    PhotoData(photo: photos[0], data: firstURL),
                    PhotoData(photo: photos[1], data: secondURL)
                )
            }
        }.eraseToAnyPublisher()
    }

    func getPhotoData(url: String) -> AnyPublisher<Data, Error> {
        guard let url = URL(string: url) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                data
            }
            .eraseToAnyPublisher()
    }


}