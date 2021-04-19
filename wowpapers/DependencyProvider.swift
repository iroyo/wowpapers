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
    
    lazy var wallpaperProvider: WallpaperProvider = WallpaperManager()
    
    lazy var queryProvider: QueryProvider = QueryManager(repository: queryRepository)
    lazy var photoProvider: PhotoProvider = PhotoManager(
        unsplashProvider: UnsplashDataSource(),
        pexelsProvider: PexelsDataSource(pageProvider: pexelsPageProvider)
    )

    
}
