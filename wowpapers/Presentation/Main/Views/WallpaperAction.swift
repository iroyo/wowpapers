//
// Created by Isaac Royo Raso on 30/1/21.
//

import SwiftUI

struct WallpaperAction: View {

    @Binding var isLoading: Bool
    let normalFabColor: Color
    let hoverFabColor: Color
    let action: () -> Void

    @State private var hovering: Bool = false

    init(
        isLoading: Binding<Bool>,
        normalColor: Color = Color.primary,
        hoverColor: Color = Color.primaryLight,
        action: @escaping () -> ()
    ) {
        _isLoading = isLoading
        normalFabColor = normalColor
        hoverFabColor = hoverColor
        self.action = action
    }

    var body: some View {
        ZStack {
            let backgroundColor = hovering ? hoverFabColor : normalFabColor
            let style = UpdateButtonStyle(hovering, backgroundColor)
            icon.buttonStyle(style)
                .disabled(isLoading)
                .onHover { isHovered in
                    hovering = isHovered
                }
            if isLoading {
                CircularProgress(size: 48, color: Color.onPrimary).withOutline()
            }
        }.transition(.opacity).animation(Animation.default.delay(0.1), value: isLoading)
    }

    var icon: some View {
        Button(action: action) {
            Image(systemName: "shuffle")
                .frame(width: 16, height: 16)
                .foregroundColor(Color.onPrimary)
        }
    }
}


fileprivate struct UpdateButtonStyle: ButtonStyle {

    private let color: Color
    private let isHovering: Bool

    init(_ isHovering: Bool, _ color: Color) {
        self.color = color
        self.isHovering = isHovering
    }

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
            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: y)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(isHovering ? animation : nil)

    }
}
