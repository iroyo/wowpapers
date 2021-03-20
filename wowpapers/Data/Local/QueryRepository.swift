//
//  QueryRepository.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 20/3/21.
//

import CoreData

struct QueryRepository {
    
    let context: NSManagedObjectContext
    
    func hasQueries() -> Bool {
        getQueries().count >= 1
    }
        
    func getQueries() -> [Query] {
        do {
            return try context.fetch(Query.fetchRequest())
        } catch {
            return []
        }
    }
    
    func addQuery(with value: String) -> Bool {
        do {
            let query = Query(context: context)
            query.name = value
            try context.save()
        } catch {
            return false
        }
        return true
    }
    
    func remove(query: Query) -> Bool {
        do {
            context.delete(query)
            try context.save()
        } catch {
            return false
        }
        return true
    }
}
