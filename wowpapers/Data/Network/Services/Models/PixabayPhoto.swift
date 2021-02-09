//
//  PexelsPhoto.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 13/1/21.
//

import Foundation

struct PixabayPhoto: Decodable, Convertible {
    let id: Int
    let imageWidth: Int
    let imageHeight: Int
    let webformatURL: String
    let largeImageURL: String
    let userId: Int
    let user: String
    let userImageURL: String

    func convert() -> Photo {
        Photo(
            width: imageWidth,
            height: imageHeight,
            originalSrc: largeImageURL,
            thumbnailSrc: webformatURL,
            photographer: Photographer(url: userURL, name: user),
            origin: .pixabay
        )
    }

    private var userURL: String {
        "https://pixabay.com/users/\(user)-\(userId)"
    }
}