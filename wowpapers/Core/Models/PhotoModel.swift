//
//  Photo.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 13/1/21.
//

import Foundation

struct Photo {
    let width: Int
    let height: Int
    let color: String
    let originalSrc: String
    let thumbnailSrc: String
    let photographer: Photographer
    let origin: Origin
}

extension Photo {

    enum Origin {
        case pexels
    }

}

struct PhotoData {
    let photo: Photo
    let data: Data
}







