//
// Created by Isaac Royo Raso on 5/2/21.
//

import Combine

protocol PhotoDataSource {

    func getPhotosFrom(category: String) -> AnyPublisher<[Photo], Error>

}
