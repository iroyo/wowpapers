//
//  UnsplashPhoto.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 1/4/21.
//

import Foundation

struct UnsplashPhoto : Decodable, Convertible {
    
    let id: String
    let createdAt: String
    let updatedAt: String
    let width: Int
    let height: Int
    let color: String
    let description: String?
    let altDescription: String?
    let urls: UnsplashPhotoLinks
    let user: UnsplashPhotographer
    
    
    func convert() -> Photo {
        Photo(
            color: color,
            width: width,
            height: height,
            originalSrc: urls.full,
            thumbnailSrc: urls.small,
            photographer: Photographer(url: user.links.html, name: user.name),
            origin: .unsplash
        )
    }
    
}

struct UnsplashPhotoLinks: Decodable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}

struct UnsplashPhotographer: Decodable {
    
    let id: String
    let username: String
    let name: String
    let links: UnsplashPhotographerLinks
}

struct UnsplashPhotographerLinks: Decodable {
    
    let html: String
    let portfolio: String

}
