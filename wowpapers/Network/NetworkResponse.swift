//
// Created by Isaac Royo Raso on 3/2/21.
//

import Foundation

struct NetworkResponse<T> {
    let result: T
    let headers: NSDictionary

    init(_ result: T, _ headers: [AnyHashable: Any]) {
        self.result = result
        self.headers = headers as NSDictionary
    }
}