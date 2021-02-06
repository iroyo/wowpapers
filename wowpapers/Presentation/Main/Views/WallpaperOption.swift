//
// Created by Isaac Royo Raso on 1/2/21.
//

import SwiftUI

struct WallpaperOption: View {

    @State private var isHovering = false
    @Binding private var state: MainViewState
    private let converter: (PhotoModel) -> PhotoData

    init(_ state: Binding<MainViewState>, block: @escaping (PhotoModel) -> PhotoData) {
        _state = state
        converter = block
    }

    var body: some View {
        content
            .fillParentWith(aspectRatio: 16 / 9)
            .overlay(Color.black.opacity(isHovering ? 0 : 0.25))
            .animation(Animation.linear(duration: 0.35), value: isHovering)
            .onHover { hovering in
                isHovering = hovering
            }
    }

    @ViewBuilder
    private var content: some View {
        switch state {
        case .loading: Rectangle().fill(Color.gray)
        case .result(let data):
            let photo = converter(data)
            if let result = NSImage(data: photo.data) {
                ResultImage(image: result, photo: photo)
            } else {
                Text("failure")
            }
        }
    }

}

fileprivate struct ResultImage: View {

    let image: NSImage
    let photo: PhotoData

    var body: some View {
        Image(nsImage: image).resizable()
    }
}
