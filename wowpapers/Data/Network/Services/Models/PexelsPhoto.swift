//
//  PexelsPhoto.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 13/1/21.
//

import Foundation

struct PexelsPhoto: Decodable, Convertible {
    let id: Int
    let width: Int
    let height: Int
    let url: String
    let src: Source
    let photographer: String
    let photographerUrl: String
    let photographerId: Int
    let avgColor: String

    func convert() -> Photo {
        Photo(
            width: width,
            height: height,
            color: avgColor,
            originalSrc: src.original,
            thumbnailSrc: src.medium,
            photographer: Photographer(url: photographerUrl, name: photographer),
            origin: .pexels
        )
    }
}

struct Source: Decodable {
    let original: String
    let large: String
    let medium: String
    let small: String
    let portrait: String
    let landscape: String
    let tiny: String
}
