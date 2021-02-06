//
// Created by Isaac Royo Raso on 6/2/21.
//

import Foundation


extension Dictionary {

    mutating func plus(_ dictionary: [Key: Value]) -> Dictionary<Key, Value> {
        for (k, v) in dictionary {
            updateValue(v, forKey: k)
        }
        return self
    }

}