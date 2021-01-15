//
// Created by Isaac Royo Raso on 15/1/21.
//

import SwiftUI

extension AsyncImage where Placeholder == Text {

    init(_ url: String) {
        self.init(url) {
            Text("Loading")
        }
    }

}

struct AsyncImage<Placeholder>: View where Placeholder: View {

    @StateObject private var loader: ImageLoader

    init(_ url: String, @ViewBuilder placeholder: () -> Placeholder) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }

    var body: some View {
        Text("")
    }
}
