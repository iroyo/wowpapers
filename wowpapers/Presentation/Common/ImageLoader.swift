//
// Created by Isaac Royo Raso on 15/1/21.
//

import Foundation

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