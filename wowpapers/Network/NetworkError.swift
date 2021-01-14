//
//  NetworkError.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 13/1/21.
//

import Foundation

enum NetworkError : Error {
    case invalidURL
    case invalidResponse(Int = 500)
    case emptyResponse
}
