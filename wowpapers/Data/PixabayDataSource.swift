//
// Created by Isaac Royo Raso on 5/2/21.
//

import Combine
import Foundation

struct PixabayDataSource: PhotoDataSource {
    
    private let LIMIT = 3
    
    let pageProvider: PageProvider

    func getRandomPhotos(from category: String) -> AnyPublisher<[Photo], Error> {
        let maxPage = pageProvider.getPage(for: category)
        let offset = Int.random(in: 1...maxPage)
        return PixabayApi.searchPhotos(query: category, offset, LIMIT).result()
            .handleEvents(receiveOutput: { response in
                if maxPage == 1 {
                    let total = response.totalHits / LIMIT
                    pageProvider.setPage(max: total, for: category)
                }
            })
            .map(\.hits)
            .convert()
    }

}
