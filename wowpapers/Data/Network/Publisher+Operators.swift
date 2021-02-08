//
// Created by Isaac Royo Raso on 6/2/21.
//

import Combine

extension Publisher {

    func sinkToResource(_ completion: @escaping (Resource<Output>) -> Void) -> AnyCancellable {
        sink(
            receiveCompletion: { result in
                if case let .failure(error) = result {
                    completion(.failed(error))
                }
            },
            receiveValue: { output in
                completion(.loaded(output))
            }
        )
    }

    func result<T>() -> AnyPublisher<T, Failure> where Output == NetworkResponse<T> {
        map { response -> T in
            response.result
        }.eraseToAnyPublisher()
    }

    func convert<T, R: Convertible>() -> AnyPublisher<[T], Failure> where Output == Array<R>, R.Item == T {
        map { array -> [T] in
            array.map { r -> T in
                r.convert()
            }
        }.eraseToAnyPublisher()
    }

}