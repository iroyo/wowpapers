//
// Created by Isaac Royo Raso on 19/1/21.
//

import SwiftUI

struct CircularProgress: View {

    @State var isAnimating = false

    var repeatingAnimation: Animation {
        Animation
                .linear(duration: 2)
                .repeatForever()
    }

    var body: some View {
        MyShape()
                .stroke(Color.blue, lineWidth: 6)
    }
}

struct MyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: 24,
                startAngle: .degrees(0),
                endAngle: .degrees(90),
                clockwise: true
        )
        return p
    }
}
