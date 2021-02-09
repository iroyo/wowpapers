//
//  MainViewModel.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 13/1/21.
//

import Combine
import Foundation

class MainViewModel: ObservableObject {

    private var cancellableSet: Set<AnyCancellable> = []
    private let photoProvider: PhotoProvider = PhotoManager()

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
        loading = true
        photoProvider.searchPhotoPair(from: "mountain").sinkToResource { resource in
            self.loading = false
            self.wallpapers = resource
        }.store(in: &cancellableSet)
    }

    func applyWallpaper() {
        print("applyWallpaper")
    }

}
