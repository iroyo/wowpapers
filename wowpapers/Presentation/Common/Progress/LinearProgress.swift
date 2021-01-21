//
// Created by Isaac Royo Raso on 21/1/21.
//

import SwiftUI

struct LinearProgress: View {

    @State private var percentage: CGFloat = 0

    var body: some View {
        LinearProgressShape(percentage: percentage).fill(Color.primary)
                .onAppear {
                    withAnimation(.linear(duration: 3)) {
                        percentage = 100
                    }
                }
    }
}

struct LinearProgressShape: Shape {
    private let thickness: CGFloat = 8

    var percentage: CGFloat

    public var animatableData: CGFloat {
        get {
            CGFloat(percentage)
        }
        set {
            percentage = CGFloat(newValue)
        }
    }

    func path(in rect: CGRect) -> Path {
        let path = Path { path in
            let width = (percentage * rect.width) / 100
            let x = percentage < 50 ? 0 : percentage - 50
            path.addRect(CGRect(x: x, y: rect.height - thickness, width: width, height: thickness))
        }
        return path
    }


}
