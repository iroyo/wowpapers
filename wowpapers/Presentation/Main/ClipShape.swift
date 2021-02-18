//
// Created by Isaac Royo Raso on 30/1/21.
//

import SwiftUI

enum CutConfiguration {

    case above, below

    var configuration: (angle: Angle, point: UnitPoint) {
        switch self {
        case .above:
            return (.degrees(180), .top)
        case .below:
            return (.degrees(0), .bottom)
        }
    }
}


struct SemiCircle: Shape {

    private let radius: CGFloat = 128
    private let smallRadius: CGFloat = 16

    func path(in rect: CGRect) -> Path {
        Path { path in
            let yBase = rect.height - smallRadius
            let yApex = yBase - radius + 12
            let negativeX = rect.midX - radius
            let positiveX = rect.midX + radius
            path.addArc(center: CGPoint(x: negativeX - smallRadius, y: yBase), radius: smallRadius, startAngle: .degrees(-270), endAngle: .degrees(-360), clockwise: true)
            path.addCurve(to: CGPoint(x: positiveX, y: yBase), control1: CGPoint(x: negativeX + 36, y: yApex), control2: CGPoint(x: positiveX - 36, y: yApex))
            path.addArc(center: CGPoint(x: positiveX + smallRadius, y: yBase), radius: smallRadius, startAngle: .degrees(-180), endAngle: .degrees(-270), clockwise: true)
            path.closeSubpath()
        }
    }
}


struct Clipper: Shape {

    private let cut: CutConfiguration

    init(with cutConfiguration: CutConfiguration) {
        cut = cutConfiguration
    }

    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: .init(x: 0, y: rect.height))
            path.addLine(to: .init(x: rect.width, y: rect.height))
            path.addLine(to: .init(x: rect.width, y: 0))
            path.addPath(SemiCircle().rotation(cut.configuration.angle).scale(0.25, anchor: cut.configuration.point).path(in: rect))
        }
    }

}
