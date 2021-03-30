//
//  PexelsPhotoList.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 13/1/21.
//

import Foundation

struct PixabayPhotoList: Decodable {
    let hits: [PixabayPhoto]
    let totalHits: Int
    let total: Int
}
