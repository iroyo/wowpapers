//
// Created by Isaac Royo Raso on 25/1/21.
//

import SwiftUI

struct WallpaperView: View {

    let url = "https://images.pexels.com/photos/2387869/pexels-photo-2387869.jpeg?auto=compress&cs=tinysrgb&h=350"

    var body: some View {
        BasicAsyncImage(url)
                .frame(maxWidth: .infinity)
                .aspectRatio(16 / 9, contentMode: .fill)
                .fixedSize(horizontal: false, vertical: true)
    }
}
