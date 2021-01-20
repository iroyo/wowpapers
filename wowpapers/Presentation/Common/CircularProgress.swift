//
// Created by Isaac Royo Raso on 19/1/21.
//

import SwiftUI

struct CircularProgress: View {

    @State private var angle: Double = 0
    @State private var rotation: Double = -90

    var repeatingAnimation: Animation {
        Animation.linear(duration: 3.5).repeatForever(autoreverses: false)
    }

    var body: some View {
        CircularProgressShape(angle, rotation)
                .stroke(Color.blue, lineWidth: 6)
                .onAppear {
                    withAnimation(repeatingAnimation) {
                        self.angle = CircularProgressShape.MAX_ANGLE
                        self.rotation = 180
                    }
                }
    }
}

struct CircularProgressShape: Shape {
    static let MAX_ANGLE: Double = 270 * 6

    private let minDegreeDistance: Double = 45
    private let maxDegreeDistance: Double = 270
    private let circleRadius: CGFloat

    private var angle: Double
    private var rotation: Double

    init(_ angle: Double, _ rotation: Double, radius: CGFloat = 24) {
        circleRadius = radius
        self.angle = angle
        self.rotation = rotation
    }

    public var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(Double(angle), Double(rotation))
        }
        set {
            angle = Double(newValue.first)
            rotation = Double(newValue.second)
        }
    }

    func path(in rect: CGRect) -> Path {
        var p = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)

        let start: Double, end: Double
        let revolution: Int = Int(angle / maxDegreeDistance)
        if revolution % 2 == 0 {
            start = Double(revolution / 2) * maxDegreeDistance
            end = angle + minDegreeDistance - start
        } else {
            let factor = Double((revolution + 1) / 2)
            start = angle - factor * maxDegreeDistance
            end = maxDegreeDistance * factor + minDegreeDistance
        }
        p.addArc(center: center, radius: circleRadius, startAngle: .degrees(start), endAngle: .degrees(end), clockwise: false)
        return p.rotation(.degrees(rotation)).path(in: rect)
    }
}