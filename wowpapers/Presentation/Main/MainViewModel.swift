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
