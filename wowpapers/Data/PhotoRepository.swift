//
// Created by Isaac Royo Raso on 5/2/21.
//

import Combine

protocol PhotoRepository {

    func getPhotosFrom(category: String) -> AnyPublisher<[Photo], Error>

}
