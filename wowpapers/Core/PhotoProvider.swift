//
// Created by Isaac Royo Raso on 5/2/21.
//

import Combine
import Foundation

private enum ProviderType : CaseIterable {
    case pexels
    case pixabay
}

protocol PhotoProvider {

    func searchPhotoPair(from category: String) -> AnyPublisher<WallpaperResults, Error>

}

struct PhotoManager: PhotoProvider {

    let pexelsProvider: PhotoDataSource
    let pixabayProvider: PhotoDataSource

    private var providerType: ProviderType {
        let randomIndex = Int.random(in: 0..<ProviderType.allCases.count)
        return ProviderType.allCases[randomIndex]
    }

    private var provider: (String) -> AnyPublisher<[Photo], Error> {
        switch providerType {
        case .pexels: return pexelsProvider.getPhotos
        case .pixabay: return pixabayProvider.getPhotos
        }
    }

    func searchPhotoPair(from category: String) -> AnyPublisher<WallpaperResults, Error> {
        provider(category)
            .map { photos in
                (first: photos[0], second: photos[1])
            }
            .flatMap { pair in
                Publishers.Zip(
                    getPhotoData(url: pair.first.thumbnailSrc),
                    getPhotoData(url: pair.second.thumbnailSrc)
                ).map { firstPhoto, secondPhoto in
                    WallpaperResults(for: category, pair, firstPhoto, secondPhoto)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
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
