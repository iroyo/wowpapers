//
//  PhotosResponse.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 13/1/21.
//

import Foundation

struct PhotosResponse: Decodable {
    let photos: [PhotosResponse]
    let totalResults: Int
    let perPage: Int
    let page: Int
}
