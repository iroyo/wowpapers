//
//  PhotoResponse.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 13/1/21.
//

import Foundation

struct PhotoResponse: Decodable {
    let id: Int
    let width: Int
    let height: Int
    let url: String
    let photographer: String
    let photographerUrl: String
    let photographerId: Int
    let avgColor: String
}

struct Source : Decodable {
    let original: String
    let large: String
    let medium: String
    let small: String
    let portrait: String
    let landscape: String
    let tiny: String
}
