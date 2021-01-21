//
// Created by Isaac Royo Raso on 20/1/21.
//

import SwiftUI


struct LoadingPlaceholder : View {

    var body: some View {
        HStack {
            CircularProgress(size: 28, thickness: 14, color: .primary).withOutline()
            Text("Loading").padding(.leading, 4)
        }
    }
}

