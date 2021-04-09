//
//  MainViewModel.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 13/1/21.
//

import Combine
import Foundation

class MainViewModel: ObservableObject {
    
    private let photoProvider: PhotoProvider
    private let queryProvider: QueryProvider

    @Published var loading: Bool = true
    @Published var panelMode: PanelMode = .close()
    @Published var wallpapers: Resource<WallpaperResults> = .waiting

    var aboveWallpaper: Resource<PhotoData> {
        wallpapers.map(\.options.0)
    }

    var belowWallpaper: Resource<PhotoData> {
        wallpapers.map(\.options.1)
    }

    init(_ hasQueries: Bool, photoProvider: PhotoProvider, queryProvider: QueryProvider) {
        self.photoProvider = photoProvider
        self.queryProvider = queryProvider
        if hasQueries {
            panelMode = .close()
        } else {
            panelMode = .expanded(.category)
        }
    }
    
    func newWallpaper() {
        photoProvider.searchPhotoPair(from: queryProvider.getQuery())
            .onStart { self.loading = true }
            .onFinish { self.loading = false }
            .asResource()
            .assign(to: &self.$wallpapers)
    }

    func applyWallpaper(data: Photo) {
        if case let Resource.loaded(data) = wallpapers {
            print(data.category)
         }
    }

}
