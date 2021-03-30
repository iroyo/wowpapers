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
    
    private lazy var pexelsPageProvider = PageRepository(type: Origin.pexels.rawValue, context: context)
    private lazy var pixabayPageProvider = PageRepository(type: Origin.pixabay.rawValue, context: context)
    
    lazy var queryProvider: QueryProvider = QueryManager(repository: queryRepository)
    lazy var photoProvider: PhotoProvider = PhotoManager(
        pexelsProvider: PexelsDataSource(pageProvider: pexelsPageProvider),
        pixabayProvider: PixabayDataSource(pageProvider: pixabayPageProvider)
    )

    
}
