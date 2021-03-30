//
//  PageRepository.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 29/3/21.
//

import CoreData

struct PageRepository : PageProvider {
    
    let type: String
    let context: NSManagedObjectContext
    
    func getPage(for query: String) -> Int {
        do {
            let request: NSFetchRequest<Page> = Page.fetchRequest()
            request.predicate = NSPredicate(format: "query == %@ AND provider == %@", query, type)
            request.fetchLimit = 1
            
            guard let result = try context.fetch(request).first else {
                return 1
            }
            
            return result.total
        } catch {
            return 1
        }
    }
    
    func setPage(max: Int, for query: String) {
        do {
            let page = Page(context: context)
            page.total = max
            page.query = query
            page.provider = type
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func removePages(for query: String) {
        do {
            let request: NSFetchRequest<Page> = Page.fetchRequest()
            request.predicate = NSPredicate(format: "query == %@", query)
            
            let result = try context.fetch(request)
            result.forEach { page in context.delete(page) }
            try context.save()
        } catch {
            print(error)
        }
    }
    
}
