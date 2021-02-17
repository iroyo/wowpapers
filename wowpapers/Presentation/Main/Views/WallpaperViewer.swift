//
// Created by Isaac Royo Raso on 1/2/21.
//

import SwiftUI

struct WallpaperViewer: View {

    private var timer = Timer.publish (every: 1, on: .current, in: .common).autoconnect()

    @State var shouldAnimate = false

    @State private var isHovering = false
    private var data: Resource<PhotoData>

    init(_ data: Resource<PhotoData>) {
        self.data = data
    }

    var body: some View {
        content
            .fillParentWith(aspectRatio: 16 / 9)
            .overlay(Color.black.opacity(shouldAnimate ? 0 : 0.15))
            .animation(Animation.linear(duration: 0.15), value: shouldAnimate)
            .onHover { hovering in
                if hovering {
                    startDelay()
                } else {
                    shouldAnimate = false
                }
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

    private func startDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            if isHovering {
                shouldAnimate = true
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
