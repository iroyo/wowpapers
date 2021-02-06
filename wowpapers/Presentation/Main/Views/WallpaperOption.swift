//
// Created by Isaac Royo Raso on 1/2/21.
//

import SwiftUI

struct WallpaperOption: View {

    @State private var isHovering = false
    @Binding private var state: MainViewState
    @StateObject private var loader: CustomImageLoader
    private let converter: (PhotoPair) -> Photo

    private var result: CustomImageLoader.LoadState {
        if case let MainViewState.result(pair) = state {
            loader.load(url: converter(pair).thumbnailSrc)
        }
        return loader.imageState
    }

    init(_ state: Binding<MainViewState>, block: @escaping (PhotoPair) -> Photo) {
        _loader = StateObject(wrappedValue: CustomImageLoader())
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
        switch result {
        case .loading: Rectangle().fill(Color.gray)
        case .failure: Text("failure")
        case .success(let data):
            if let result = NSImage(data: data) {
                ResultImage(nsImage: result)
            } else {
                Text("failure")
            }
        }
    }

}

fileprivate struct ResultImage: View {

    let nsImage: NSImage

    var body: some View {
        Image(nsImage: nsImage).resizable()
    }
}

fileprivate class CustomImageLoader: ObservableObject {

    enum LoadState {
        case loading
        case failure
        case success(Data)
    }

    @Published var imageState = LoadState.loading

    func load(url: String) {
        guard let parsedURL = URL(string: url) else {
            fatalError("Invalid URL: \(url)")
        }

        let task = URLSession.shared.dataTask(with: parsedURL) { data, response, error in
            DispatchQueue.main.async {
                if let data = data, data.count > 0 {
                    self.imageState = .success(data)
                } else {
                    self.imageState = .failure
                }
            }
        }
        task.resume()
    }
}
