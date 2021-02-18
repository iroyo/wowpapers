//
//  MainViewModel.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 13/1/21.
//

import Combine
import Foundation

class MainViewModel: ObservableObject {
    
    private let provider: PhotoProvider = PhotoManager()

    @Published var loading: Bool = true
    @Published var wallpapers: Resource<WallpaperResults> = .waiting

    var aboveWallpaper: Resource<PhotoData> {
        wallpapers.map(\.options.0)
    }

    var belowWallpaper: Resource<PhotoData> {
        wallpapers.map(\.options.1)
    }

    init() {
        newWallpaper()
    }

    func newWallpaper() {
        provider.searchPhotoPair(from: "mountain")
            .onStart { self.loading = true }
            .onFinish { self.loading = false }
            .asResource()
            .assign(to: &self.$wallpapers)
    }

    func applyWallpaper(data: Photo) {
        print("applyWallpaper")
    }
    
    func updateFooter(data: Photo, isHovering: Bool) {
        
    }

}
