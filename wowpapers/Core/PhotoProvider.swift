//
// Created by Isaac Royo Raso on 5/2/21.
//

import Combine
import Foundation

enum ProviderType  {
    case pexels
}

protocol PhotoProvider {

    var provider: (String) -> AnyPublisher<[Photo], Error> { get }

}