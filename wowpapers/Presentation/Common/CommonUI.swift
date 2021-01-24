//
// Created by Isaac Royo Raso on 20/1/21.
//

import SwiftUI


struct LoadingPlaceholder : View {

    var body: some View {
        HStack {
            CircularProgress(size: 28, thickness: 14, color: .primary).withOutline()
            Text("Loading").padding(.leading, 4)
        }
    }
}

struct ImagePlaceholder : View {

    let color: Color

    init(color: Color = Color.primary) {
        self.color = color
    }

    var body: some View {
        ZStack {
            Rectangle().fill(Color.surface)
            LinearProgress(color: color).withTrack()
        }
    }

}

func BasicAsyncImage(_ url: String) -> AsyncImage<ImagePlaceholder, Text> {
    AsyncImage<ImagePlaceholder, Text>(url, failure: { Text("Error") }, placeholder: { ImagePlaceholder() }) { image in
        Image(nsImage: image).resizable()
    }
}

