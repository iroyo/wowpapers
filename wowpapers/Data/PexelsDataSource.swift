//
// Created by Isaac Royo Raso on 5/2/21.
//

import Combine
import Foundation

struct PexelsDataSource: PhotoDataSource {
    
    private let LIMIT = 2
    
    let pageProvider: PageProvider

    func getRandomPhotos(from category: String) -> AnyPublisher<[Photo], Error> {
        let maxPage = pageProvider.getPage(for: category)
        let offset = Int.random(in: 1...maxPage)
        return PexelsApi.searchPhotos(query: category, offset, LIMIT).result()
            .handleEvents(receiveOutput: { response in
                if maxPage == 1 {
                    let total = response.totalResults / LIMIT
                    pageProvider.setPage(max: total, for: category)
                }
            })
            .map(\.photos)
            .convert()
    }

}
