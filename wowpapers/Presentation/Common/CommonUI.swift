//
// Created by Isaac Royo Raso on 20/1/21.
//

import SwiftUI


func BasicAsyncImage(_ url: String) -> AsyncImage<ImagePlaceholder, Text> {
    AsyncImage<ImagePlaceholder, Text>(url, failure: { Text("Error") }, placeholder: { ImagePlaceholder() }) { image in
        Image(nsImage: image).resizable()
    }
}

fileprivate struct FillParent : ViewModifier {
    let aspectRatio: CGFloat

    func body(content: Content) -> some View {
        content.frame(maxWidth: .infinity)
            .aspectRatio(aspectRatio, contentMode: .fill)
            .fixedSize(horizontal: false, vertical: true)
    }

}

extension View {

    func fillParentWith(aspectRatio: CGFloat) -> some View {
        self.modifier(FillParent(aspectRatio: aspectRatio))
    }
}

