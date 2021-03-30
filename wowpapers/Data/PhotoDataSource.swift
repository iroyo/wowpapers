//
// Created by Isaac Royo Raso on 5/2/21.
//

import Combine

protocol PhotoDataSource {

    func getRandomPhotos(from category: String) -> AnyPublisher<[Photo], Error>

}
