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
        let clip = Clipper(with: cut)
        return content
            .fillParentWith(aspectRatio: 16 / 9)
            .overlay(Color.black.opacity(shouldAnimate ? 0 : 0.15))
            .clipShape(clip)
            .contentShape(clip)
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
                Button(action: { onClick(data.photo) }) {
                    viewer(for: result, with: data.photo)
                }
                .buttonStyle(PlainButtonStyle())
            } else {
                Text("failure")
            }
        case .failed(let error): Text(error.localizedDescription).frame(maxHeight: .infinity)
        }
    }
    
    private func viewer(for result: NSImage, with data: Photo) -> some View {
        ZStack(alignment: .topLeading) {
            Image(nsImage: result).resizable()
            if shouldAnimate {
                PhotographerLabel(data.photographer)
                    .frame(maxWidth: 110, alignment: .leading)
                    .padding(12)
            }
        }
    }

    // simulate debounce
    private func startDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            if isHovering {
                shouldAnimate = true
            }
        }
    }

}

fileprivate struct PhotographerLabel : View {
    
    private let photographer: Photographer
    
    init(_ data: Photographer) {
        photographer = data
    }
    
    var body: some View {
        HStack(spacing: 2) {
            Text("by")
                .foregroundColor(.white)
                .font(.system(size: 10))
            Text(photographer.name)
                .foregroundColor(.white)
                .font(.system(size: 10))
                .fontWeight(.bold)
                .truncationMode(.tail)
                .lineLimit(1)
                
        }
        .padding(4)
        .background(Color.gray)
        .cornerRadius(4)
        
    }
    
}


