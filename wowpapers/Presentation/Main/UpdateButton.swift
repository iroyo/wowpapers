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

    func makeBody(configuration: Configuration) -> some View {
        let y: CGFloat = configuration.isPressed ? 0 : 4
        let radius: CGFloat = configuration.isPressed ? 1.5 : 4
        let shadowColor: Color = configuration.isPressed ? Color.black.opacity(0.25) : Color.black.opacity(0.45)
        let animation: Animation = configuration.isPressed ? .default : Animation.interpolatingSpring(stiffness: 20, damping: 3).speed(2.5)
        return configuration.label
                .frame(width: 48, height: 48)
                .background(color)
                .cornerRadius(24)
                .shadow(color: shadowColor, radius: radius, x: 0, y: y)
                .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
                .animation(animation)

    }
}
