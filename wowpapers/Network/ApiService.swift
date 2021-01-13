//
// Created by Isaac Royo Raso on 13/1/21.
//

import Foundation

func getPhotos() {
    NetworkManager<PhotosResponse>().makeRequest("search", params: [
        "orientation": "landscape",
        "page": String(Int.random(in: 0...1000)),
        "query": "nature",
        "per_page": "1",
    ]) { output in
        switch output {
        case .error(let problem):
            print(problem)
        case .success(let result):
            print(result)
        }
    }
}
