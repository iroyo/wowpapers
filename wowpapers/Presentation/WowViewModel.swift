//
//  WowViewModel.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 13/1/21.
//

import Combine
import Foundation

class WowViewModel: ObservableObject {

    @Published var photoProvider: PhotoProvider = PhotoProvider.system("")
    
    func getNewWallpaper() {
        getPhotos { output in
            if case Output.success(let data) = output {
                self.photoProvider = data
            }
        }
    }    
    
}
