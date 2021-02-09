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
    let originalSrc: String
    let thumbnailSrc: String
    let photographer: Photographer
    let origin: Origin
    let color: String?

    init(color: String? = nil, width: Int, height: Int, originalSrc: String, thumbnailSrc: String, photographer: Photographer, origin: Origin) {
        self.width = width
        self.height = height
        self.color = color
        self.originalSrc = originalSrc
        self.thumbnailSrc = thumbnailSrc
        self.photographer = photographer
        self.origin = origin
    }
}

extension Photo {

    enum Origin {
        case pexels
        case pixabay
    }

}

struct PhotoData {
    let photo: Photo
    let data: Data
}







