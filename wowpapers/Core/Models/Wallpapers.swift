//
// Created by Isaac Royo Raso on 8/2/21.
//

import Foundation

struct Wallpapers {
    let above: PhotoData
    let below: PhotoData

    init(_ pair: (Photo, Photo), _ topData: Data, _ bottomData: Data) {
        above = PhotoData(photo: pair.0, data: topData)
        below = PhotoData(photo: pair.1, data: bottomData)
    }
}