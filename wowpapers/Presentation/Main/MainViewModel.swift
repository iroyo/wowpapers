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

    @Published var state: MainViewState = .loading

    init() {
        newWallpaper()
    }

    func newWallpaper() {
        state = .loading
        photoProvider.searchPhotoPair(from: "mountain").sink(receiveCompletion: { _ in  }) { model in
            self.state = .result(model)
        }.store(in: &cancellableSet)
    }

    func applyWallpaper() {
        print("applyWallpaper")
    }

    func saveWallpaper() {
        print("saveWallpaper")
    }

}

enum MainViewState {
    case loading, result(PhotoModel)
}
