//
// Created by Isaac Royo Raso on 1/2/21.
//

import SwiftUI

struct WallpaperViewer: View {

    @State var shouldAnimate = false

    @State private var isHovering = false
    private let data: Resource<PhotoData>
    private let cut: CutConfiguration
    private let onClick: (Photo) -> Void
    private let onHover: (Photo, Bool) -> Void
    
    private var yShadow: CGFloat {
        switch cut {
        case .above: return -1
        case .below: return +2
        }
    }

    init(
        _ data: Resource<PhotoData>,
        cut: CutConfiguration,
        onClick: @escaping (Photo) -> Void,
        onHover: @escaping (Photo, Bool) -> Void
    ) {
        self.cut = cut
        self.data = data
        self.onClick = onClick
        self.onHover = onHover
    }

    var body: some View {
        let radius: CGFloat = shouldAnimate ? 2 : 0
        let y = shouldAnimate ? yShadow : 0
        return content
            .fillParentWith(aspectRatio: 16 / 9)
            .overlay(Color.black.opacity(shouldAnimate ? 0 : 0.15))
            .clipShape(Clipper(with: cut))
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.2), radius: radius, x: 0, y: y)
            .animation(Animation.linear(duration: 0.15), value: shouldAnimate)
            .onHover { hovering in
                if hovering {
                    startDelay()
                } else {
                    shouldAnimate = false
                    if case let Resource.loaded(data) = data {
                        onHover(data.photo, false)
                    }
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
                Button(action: { onClick(data.photo) }) {
                    Image(nsImage: result)
                        .renderingMode(.original)
                        .resizable()
                }.buttonStyle(PlainButtonStyle())
            } else {
                Text("failure")
            }
        case .failed(let error): Text(error.localizedDescription).frame(maxHeight: .infinity)
        }
    }

    // simulate debounce
    private func startDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            if isHovering {
                shouldAnimate = true
                if case let Resource.loaded(data) = data {
                    onHover(data.photo, true)
                }
            }
        }
    }

}
