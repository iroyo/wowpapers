//
// Created by Isaac Royo Raso on 8/2/21.
//

import Foundation

struct WallpaperResults {
    let options: (PhotoData, PhotoData)
    let category: String

    init(for category: String, _ pair: (Photo, Photo), _ firstPhoto: Data, _ secondPhoto: Data) {
        self.category = category.capitalized
        options = (
            PhotoData(photo: pair.0, data: firstPhoto),
            PhotoData(photo: pair.1, data: secondPhoto)
        )
    }
    
    var origin: Origin {
        options.0.photo.origin
    }
}
