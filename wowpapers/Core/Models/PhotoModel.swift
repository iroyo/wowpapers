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
    let origin: PhotoOrigin
    let thumbnailSrc: String
    let originalSrc: String
    let photographer: Photographer

    var src: String {
        originalSrc
    }
}

enum PhotoProvider: SourceProvider {
    case system(String)
    case external(Photo)

    var src: String {
        switch self {
        case .system(let src): return src
        case .external(let photo): return photo.src
        }
    }

}

