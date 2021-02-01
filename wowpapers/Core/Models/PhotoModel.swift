//
//  Photo.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 13/1/21.
//

import Foundation

protocol SourceProvider {
    var src: String { get }
}

struct Photo: SourceProvider {
    let width: Int
    let height: Int
    let color: String
    let thumbnailSrc: String
    let originalSrc: String
    let photographer: Photographer

    var src: String {
        originalSrc
    }
}

struct PhotoPair {
    let first: Photo
    let second: Photo
    let origin: PhotoOrigin

    init(_ photos: [Photo], origin: PhotoOrigin) {
        first = photos[0]
        second = photos[1]
        self.origin = origin
    }
}

