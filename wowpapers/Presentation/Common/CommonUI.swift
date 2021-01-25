//
// Created by Isaac Royo Raso on 20/1/21.
//

import SwiftUI


func BasicAsyncImage(_ url: String) -> AsyncImage<ImagePlaceholder, Text> {
    AsyncImage<ImagePlaceholder, Text>(url, failure: { Text("Error") }, placeholder: { ImagePlaceholder() }) { image in
        Image(nsImage: image).resizable()
    }
}

struct MaxWidthButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.frame(maxWidth: .infinity)
    }
}

