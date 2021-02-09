//
// Created by Isaac Royo Raso on 8/2/21.
//

import Foundation

struct WallpaperResults {
    let options: (PhotoData, PhotoData)
    let provider: ProviderType
    let category: String

    init(for category: String, provider: ProviderType, _ pair: (Photo, Photo), _ firstPhoto: Data, _ secondPhoto: Data) {
        self.category = category
        self.provider = provider
        options = (
            PhotoData(photo: pair.0, data: firstPhoto),
            PhotoData(photo: pair.1, data: secondPhoto)
        )
    }
}