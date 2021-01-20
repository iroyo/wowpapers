//
// Created by Isaac Royo Raso on 15/1/21.
//

import SwiftUI

func DefaultAsyncImage(_ url: String) -> AsyncImage<Text, Text> {
    AsyncImage<Text, Text>(url, failure: { Text("Error") }, placeholder: { Text("Loading") }) { image in
        Image(nsImage: image).resizable()
    }
}

struct AsyncImage<Placeholder: View, Failure: View>: View {

    @ObservedObject private var loader: ImageLoader

    private let image: (NSImage) -> Image
    private let placeholder: Placeholder
    private let failure: Failure

    init(_ url: String,
         @ViewBuilder failure: () -> Failure,
         @ViewBuilder placeholder: () -> Placeholder,
         @ViewBuilder image: @escaping (NSImage) -> Image = Image.init(nsImage:)
    ) {
        loader = ImageLoader(url: url)
        self.placeholder = placeholder()
        self.failure = failure()
        self.image = image
    }

    @ViewBuilder
    var body: some View {
        switch loader.state {
        case .loading: placeholder
        case .failure: failure
        case .success(let data):
            if let result = NSImage(data: data) {
                image(result)
            } else {
                failure
            }
        }
    }
}

class ImageLoader: ObservableObject {

    enum LoadState {
        case loading
        case failure
        case success(Data)
    }

    @Published var state = LoadState.loading

    init(url: String) {
        guard let parsedURL = URL(string: url) else {
            fatalError("Invalid URL: \(url)")
        }

        let task = URLSession.shared.dataTask(with: parsedURL) { data, response, error in
            if let data = data, data.count > 0 {
                self.state = .success(data)
            } else {
                self.state = .failure
            }

            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
        task.resume()
    }
}
