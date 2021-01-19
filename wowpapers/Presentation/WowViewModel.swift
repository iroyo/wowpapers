//
//  WowViewModel.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 13/1/21.
//

import Combine
import Foundation

class WowViewModel: ObservableObject {

    @Published var photo: Photo?

    init() {
        photo = nil
        //getNewWallpaper()
    }
    
    func getNewWallpaper() {
        getPhotos { output in
            if case Output.success(let data) = output {
                if case PhotoProvider.external(let photo) = data {
                    print(photo.thumbnailSrc)
                    self.photo = photo
                }
            }
        }
    }    
    
}
