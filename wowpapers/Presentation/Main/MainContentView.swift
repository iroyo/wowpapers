//
//  MainContentView.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 13/1/21.
//

import SwiftUI

struct MainContentView: View {

    @StateObject var viewModel = MainViewModel()

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 16) {
                Image("pexels")
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .aspectRatio(16 / 9, contentMode: .fill)
                        .fixedSize(horizontal: false, vertical: true)
                        .clipShape(Clipper(.bottom))
                        .cornerRadius(8)
                Image("pexels")
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .aspectRatio(16 / 9, contentMode: .fill)
                        .fixedSize(horizontal: false, vertical: true)
                        .clipShape(Clipper(.top))
                        .cornerRadius(8)
            }

        }.padding().frame(width: 320)

    }
}


enum CutConfiguration {

    case top, bottom

    var configuration: (angle: Angle, point: UnitPoint) {
        switch self {
        case .top:
            return (.degrees(180), .top)
        case .bottom:
            return (.degrees(0), .bottom)
        }
    }
}


struct SemiCircle: Shape {

    private let radius: CGFloat = 128
    private let smallRadius: CGFloat = 16
    private let factor: CGFloat = 20

    func path(in rect: CGRect) -> Path {
        Path { path in
            let yBase = rect.height - smallRadius
            let yApex = yBase - radius - factor
            let negativeX = rect.midX - radius
            let positiveX = rect.midX + radius
            path.addArc(center: CGPoint(x: negativeX - smallRadius, y: yBase), radius: smallRadius, startAngle: .degrees(-270), endAngle: .degrees(-360), clockwise: true)
            path.addCurve(to: CGPoint(x: positiveX, y: yBase), control1: CGPoint(x: negativeX + factor, y: yApex), control2: CGPoint(x: positiveX - factor, y: yApex))
            path.addArc(center: CGPoint(x: positiveX + smallRadius, y: yBase), radius: smallRadius, startAngle: .degrees(-180), endAngle: .degrees(-270), clockwise: true)
            path.closeSubpath()
        }
    }
}

struct Clipper: Shape {

    private let cut: CutConfiguration

    init(_ cutConfiguration: CutConfiguration) {
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

struct WowContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
