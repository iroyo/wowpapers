//
// Created by Isaac Royo Raso on 3/2/21.
//

import Foundation

struct NetworkResponse<T> {
    let result: T
    let headers: NSDictionary
    let timeInterval: TimeInterval

    init(_ result: T, _ timeInterval: TimeInterval, _ headers: [AnyHashable: Any]) {
        self.result = result
        self.timeInterval = timeInterval
        self.headers = headers as NSDictionary
    }
}