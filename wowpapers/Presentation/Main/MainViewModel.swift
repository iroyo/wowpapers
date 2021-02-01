//
//  MainViewModel.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 13/1/21.
//

import Combine
import Foundation

class MainViewModel: ObservableObject {

    @Published var state: MainViewState = .loading

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
    case idle, loading, result
}
