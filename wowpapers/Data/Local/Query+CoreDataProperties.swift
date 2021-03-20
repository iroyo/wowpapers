//
//  Query+CoreDataProperties.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 18/3/21.
//
//

import Foundation
import CoreData


extension Query {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Query> {
        NSFetchRequest<Query>(entityName: "Query")
    }

    @NSManaged public var name: String

}
