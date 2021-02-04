//
//  MainViewModel.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 13/1/21.
//

import Combine
import Foundation

class MainViewModel: ObservableObject {

    var cancellableSet: Set<AnyCancellable> = []

    @Published var state: MainViewState = .loading

    init() {
        newWallpaper()
    }

    func newWallpaper() {
        state = .loading
        PexelsApi.photos(query: "nature")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { list in
                self.state = .result(PhotoPair(list.photos.map { photo in photo.convert() }, origin: .pexels))
            }).store(in: &cancellableSet)
    }

    func applyWallpaper() {
        print("applyWallpaper")
    }

    func saveWallpaper() {
        print("saveWallpaper")
    }

}

enum MainViewState {
    case loading, result(PhotoPair)
}
