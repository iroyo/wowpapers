//
// Created by Isaac Royo Raso on 30/1/21.
//

import SwiftUI

struct UpdateButton: View {

    @State private var hovering = false

    var body: some View {
        let backgroundColor = hovering ? Color.fabLight : Color.fab

        return Button(action: {}) {
            Image(systemName: "shuffle")
                    .frame(width: 16, height: 16)
                    .foregroundColor(Color.white)
        }
                .buttonStyle(UpdateButtonStyle(color: backgroundColor))
                .onHover { isHovered in
                    hovering = isHovered
                }

    }
}

struct UpdateButtonStyle: ButtonStyle {

    let color: Color

    private let size: CGFloat = 48
    private var corners: CGFloat {
        size / 2
    }

    func makeBody(configuration: Configuration) -> some View {
        let y: CGFloat = configuration.isPressed ? 1 : 4
        let animation: Animation = configuration.isPressed ? .default : Animation.interpolatingSpring(stiffness: 35, damping: 4.5).speed(2.5)
        return configuration.label
                .frame(width: size, height: size)
                .background(color)
                .cornerRadius(corners)
                .shadow(color: Color.black.opacity(0.45), radius: 4, x: 0, y: y)
                .scaleEffect(configuration.isPressed ? 0.85 : 1.0)
                .animation(animation)

    }
}
