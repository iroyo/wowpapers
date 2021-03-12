//
//  WallpaperModule.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 4/3/21.
//

import SwiftUI

fileprivate struct RoundedContainer : ViewModifier {
    
    private let radius: CGFloat
    
    init(with radius: CGFloat) {
        self.radius = radius
    }
    
    func body(content: Content) -> some View {
        let effect = VisualEffectView(material: .menu, blendingMode: .withinWindow)
        return content
            .background(effect)
            .cornerRadius(radius)
            .shadow(color: Color.black.opacity(0.25), radius: 3.5, x: 0, y: 2)
    }
}

extension View {
    
    func roundedCard(radius: CGFloat = 10) -> some View {
        modifier(RoundedContainer(with: radius))
    }
}
