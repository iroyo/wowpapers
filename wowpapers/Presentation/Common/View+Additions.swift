//
//  View+Additions.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 23/2/21.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func `if`<T>(_ condition: Bool, transform: (Self) -> T) -> some View where T : View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
}
