//
//  Page+CoreDataProperties.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 27/4/21.
//
//

import Foundation
import CoreData


extension Page {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Page> {
        return NSFetchRequest<Page>(entityName: "Page")
    }

    @NSManaged public var max: Int32
    @NSManaged public var query: String
    @NSManaged public var provider: String
    
    var total: Int {
        get { return Int(max) }
        set { max = Int32(newValue) }
    }

}

extension Page : Identifiable {

}
