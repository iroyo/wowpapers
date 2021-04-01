//
//  UnsplashDataSource.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 1/4/21.
//

import Combine
import Foundation

struct UnsplashDataSource: PhotoDataSource {
    
    func getRandomPhotos(from category: String) -> AnyPublisher<[Photo], Error> {
        return UnsplashApi.searchPhotos(query: category, 2)
            .result()
            .convert()
    }

}
