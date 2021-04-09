//
// Created by Isaac Royo Raso on 1/2/21.
//

import SwiftUI

struct WallpaperViewer: View {

    @State var shouldAnimate = false

    @State private var isHovering = false
    
    private let data: Resource<PhotoData>
    private let cut: CutConfiguration
    private let hoverIsEnabled: Bool
    private let onClick: (Photo) -> Void

    init(
        shouldHover: Bool,
        cut: CutConfiguration,
        data: Resource<PhotoData>,
        onClick: @escaping (Photo) -> Void = {_ in }
    ) {
        self.cut = cut
        self.data = data
        self.onClick = onClick
        self.hoverIsEnabled = shouldHover
    }

    var body: some View {
        let clip = Clipper(with: cut)
        return content
            .fillParentWith(aspectRatio: 16 / 9)
            .clipShape(clip)
            .contentShape(clip)
    }
    
    private var rectangle: some View {
        Rectangle().fill(Color.gray)
    }

    @ViewBuilder
    private var content: some View {
        switch data {
        case .waiting: rectangle
        case .loaded(let data): displayViewer(for: data)
        case .failed(let error): rectangle.overlay(ErrorLabel(message: error.localizedDescription))
        }
    }
    
    @ViewBuilder
    private func displayViewer(for result: PhotoData) -> some View {
        if let image = NSImage(data: result.data) {
            ZStack {
                Image(nsImage: image)
                    .resizable()
                    .animation(Animation.linear(duration: 0.15), value: shouldAnimate)
                if shouldAnimate {
                    Color.black.opacity(0.25)
                    PhotoAction(data: result.photo, callback: onClick)
                }
            }.onHover { hovering in
                if hoverIsEnabled {
                    if hovering {
                        startDelay()
                    } else {
                        shouldAnimate = false
                    }
                    isHovering = hovering
                }
            }
        } else {
            rectangle.overlay(ErrorLabel(message: "Failed loading image"))
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

fileprivate struct ErrorLabel : View {
    
    let message: String
    
    var body: some View {
        print(message)
        return Text(message)
            .fontWeight(.medium)
            .lineLimit(1)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(Color.white.opacity(0.65))
            .cornerRadius(16)
            .padding()
    }
}

fileprivate struct PhotoAction : View {
    
    let data: Photo
    let callback: (Photo) -> Void
    
    var body: some View {
        VStack(spacing: 4) {
            Button(action: {
                callback(data)
            }, label: {
                Text("Apply")
                    .foregroundColor(Color.primary)
                    .fontWeight(.bold)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 24)
                    .background(VisualEffectView(material: .popover, blendingMode: .withinWindow))
                    .cornerRadius(24)
            }).buttonStyle(PlainButtonStyle())
            PhotographerLabel(data.photographer)
        }
    }
}

fileprivate struct PhotographerLabel : View {
    
    @Environment(\.openURL) var openURL
    
    @State private var colorText = Color.white
    
    private let photographer: Photographer
    
    init(_ data: Photographer) {
        photographer = data
    }
    
    var body: some View {
        Button {
            openURL(URL(string: photographer.url)!)
        } label: {
            HStack(spacing: 2) {
                Text("by")
                    .foregroundColor(colorText)
                    .font(.system(size: 10))
                Text(photographer.name)
                    .foregroundColor(colorText)
                    .font(.system(size: 10))
                    .fontWeight(.bold)
                    .truncationMode(.tail)
                    .lineLimit(1)
            }
            .padding(.vertical, 2)
        }
        .buttonStyle(PlainButtonStyle())
        .onHover { hovering in
            withAnimation {
                colorText = hovering ? Color.white.opacity(0.65) : Color.white
            }
        }
    }
    
}


