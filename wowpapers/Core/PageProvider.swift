//
//  PageProvider.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 29/3/21.
//

import Foundation

protocol PageProvider {
    
    func getPage(for query: String) -> Int
    
    func setPage(max: Int, for query: String)
    
    func removePages(for query: String)
}
