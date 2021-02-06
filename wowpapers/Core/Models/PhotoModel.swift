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
    let originType: PhotoOrigin
    let photographer: Photographer
}

struct PhotoPair {
    let top: Photo
    let bottom: Photo

    init(_ photos: [Photo]) {
        top = photos[0]
        bottom = photos[1]
    }
}

struct PhotoData {
    let photo: Photo
    let data: Data
}

struct PhotoModel {
    let top: PhotoData
    let bottom: PhotoData

    init(_ pair: PhotoPair, _ topData: Data, _ bottomData: Data) {
        top = PhotoData(photo: pair.top, data: topData)
        bottom = PhotoData(photo: pair.bottom, data: bottomData)
    }
}





