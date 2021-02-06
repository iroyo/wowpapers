//
// Created by Isaac Royo Raso on 6/2/21.
//

import Foundation

enum HTTPMethod<T: Encodable> {
    case get
    case delete
    case put(body: T)
    case post(body: T)
    case patch(body: T)

    var name: String {
        switch self {
        case .get: return "GET"
        case .put: return "PUT"
        case .post: return "POST"
        case .patch: return "PATCH"
        case .delete: return "DELETE"
        }
    }

    var body: T? {
        switch self {
        case .put(let body): return body
        case .post(let body): return body
        case .patch(let body): return body
        default: return nil
        }
    }

}
