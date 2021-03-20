//
//  QueryManager.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 19/3/21.
//

import CoreData

struct QueryManager : QueryProvider {
    
    private let defaultQuery = "mountain"
   
    let repository: QueryRepository
    
    func getQuery() -> String {
        repository.getQueries().randomElement()?.name ?? defaultQuery
    }
    
    
}
