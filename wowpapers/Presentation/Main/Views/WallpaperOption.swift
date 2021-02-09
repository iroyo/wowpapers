//
// Created by Isaac Royo Raso on 1/2/21.
//

import SwiftUI

struct WallpaperOption: View {

    @State private var isHovering = false
    private var data: Resource<PhotoData>


    init(_ data: Resource<PhotoData>) {
        self.data = data
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
        switch data {
        case .waiting: Rectangle().fill(Color.gray)
        case .loaded(let data):
            if let result = NSImage(data: data.data) {
                ResultImage(image: result, photo: data)
            } else {
                Text("failure")
            }
        case .failed(let error): Text(error.localizedDescription).frame(maxHeight: .infinity)
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
