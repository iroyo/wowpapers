//
//  PexelsPhotoList.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 13/1/21.
//

import Foundation

struct PexelsPhotoList: Decodable {
    let photos: [PexelsPhoto]
    let totalResults: Int
    let perPage: Int
    let page: Int
}
