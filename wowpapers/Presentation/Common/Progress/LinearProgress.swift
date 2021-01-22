//
// Created by Isaac Royo Raso on 21/1/21.
//

import SwiftUI

struct LinearProgress: View {

    private let thickness: CGFloat
    private let color: Color

    @State private var percentage: CGFloat = 0

    init(thickness: CGFloat = 6, color: Color = Color(red: 0.263, green: 0.667, blue: 0.545)) {
        self.color = color
        self.thickness = thickness
    }

    var repeatingAnimation : Animation {
        Animation.linear(duration: 2.5).repeatForever(autoreverses: false)
    }

    var body: some View {
        LinearProgressShape(thickness: thickness, percentage: percentage)
                .fill(color)
                .onAppear {
                    withAnimation(repeatingAnimation) {
                        percentage = 100
                    }
                }
    }
}

fileprivate struct LinearProgressShape: Shape {
    private let breakPointPercentage: CGFloat = 35

    let thickness: CGFloat

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
        Path { path in
            let x, width: CGFloat
            if percentage < breakPointPercentage {
                x = 0
            } else {
                let diff = percentage - breakPointPercentage
                let factor = diff / (100 - breakPointPercentage)
                x = ((diff * rect.width) / breakPointPercentage) * factor
            }
            width = (percentage * rect.width) / 100
            path.addRect(CGRect(x: x, y: rect.height - thickness, width: width, height: thickness))
        }
    }

}

fileprivate struct Track: ViewModifier {
    let color: Color
    let thickness: CGFloat

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            Rectangle().fill(color).frame(height: thickness)
            content
        }
    }
}

extension LinearProgress {

    func withTrack() -> some View {
        self.modifier(Track(color: color.opacity(0.35), thickness: thickness))
    }

    func withTrack(color: Color) -> some View {
        self.modifier(Track(color: color, thickness: thickness))
    }

}
