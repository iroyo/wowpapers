//
//  DependencyProvider.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 19/3/21.
//

import CoreData

class DependencyProvider {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    lazy var queryRepository = QueryRepository(context: context)
    
    lazy var queryProvider: QueryProvider = QueryManager(repository: queryRepository)
    lazy var photoProvider: PhotoProvider = PhotoManager(
        pexelsProvider: PexelsDataSource(),
        pixabayProvider: PixabayDataSource()
    )

    
}
