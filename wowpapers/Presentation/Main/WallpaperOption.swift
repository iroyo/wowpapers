//
// Created by Isaac Royo Raso on 1/2/21.
//

import SwiftUI

struct WallpaperOption: View {

    @Binding private var state: MainViewState
    @StateObject private var loader: CustomImageLoader
    private let converter: (PhotoPair) -> Photo

    var result: CustomImageLoader.LoadState {
        if case let MainViewState.result(pair) = state {
            loader.load(url: converter(pair).thumbnailSrc)
        }
        return loader.imageState
    }

    init(_ state: Binding<MainViewState>, converter: @escaping (PhotoPair) -> Photo) {
        _state = state
        _loader = StateObject(wrappedValue: CustomImageLoader())
        self.converter = converter
    }


    var body: some View {
        content
            .fillParentWith(aspectRatio: 16 / 9)
    }

    @ViewBuilder
    private var content: some View {
        switch result {
        case .loading: Text("loading")
        case .failure: Text("failure")
        case .success(let data):
            if let result = NSImage(data: data) {
                Image(nsImage: result).resizable()
            } else {
                Text("failure")
            }
        }
    }

}

class CustomImageLoader: ObservableObject {

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

enum WallpaperState {
    case waiting, request(Photo)
}
