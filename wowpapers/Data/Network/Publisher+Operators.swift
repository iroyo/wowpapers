//
// Created by Isaac Royo Raso on 6/2/21.
//

import Combine

extension Publisher {

    func onStart(block: @escaping () -> Void) -> Publishers.HandleEvents<Self> {
        handleEvents(receiveRequest: { _ in block() })
    }

    func onStart(block: @escaping (Subscribers.Demand) -> Void) -> Publishers.HandleEvents<Self> {
        handleEvents(receiveRequest: block)
    }

    func onFinish(block: @escaping () -> Void) -> Publishers.HandleEvents<Self> {
        handleEvents(receiveOutput: { _ in block() })
    }

    func onFinish(block: @escaping (Output) -> Void) -> Publishers.HandleEvents<Self> {
        handleEvents(receiveOutput: block)
    }

    func asResource<T>() -> AnyPublisher<Resource<T>, Never> where Output == T {
        map { output -> Resource<T> in
            Resource.loaded(output)
        }.catch { error in
            Just<Resource<T>>(.failed(error))
        }.eraseToAnyPublisher()
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
