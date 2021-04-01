//
//  FlickrDataSource.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 1/4/21.
//

import Combine
import Foundation

struct FlickrDataSource: PhotoDataSource {
    
    private let LIMIT = 2
    
    let pageProvider: PageProvider

    func getRandomPhotos(from category: String) -> AnyPublisher<[Photo], Error> {
        let maxPage = pageProvider.getPage(for: category)
       
        let offset = Int.random(in: 1...maxPage)
        print("maxpage \(maxPage) offset \(offset)")
        return FlickrApi.searchPhotos(query: category, offset, LIMIT)
            .result()
            .map(\.photos)
            .handleEvents(receiveOutput: { response in
                if maxPage == 1 {
                    pageProvider.setPage(max: response.pages, for: category)
                }
            })
            .map(\.photo)
            .convert()
    }

}
