//
//  WallpaperModule.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 4/3/21.
//

import SwiftUI

struct ConfigurationBox<Content> : View where Content : View {
    
    @State private var isHovering = false
    
    private let title: String
    private let options: () -> Content
    
    init(title: String, @ViewBuilder options: @escaping () -> Content) {
        self.title = title
        self.options = options
    }
    
    var body: some View {
        RoundedContainer(HStack(alignment: .center, spacing: 0) {
            content.frame(maxWidth: .infinity, alignment: .leading)
            icon.opacity(isHovering ? 1 : 0)
        }).onHover { isHovering in
            self.isHovering = isHovering
        }
    }
    
    private var icon: some View {
        Image(systemName: "chevron.right")
            .font(.system(size: 12, weight: .bold, design: .rounded))
            .foregroundColor(Color.gray)
    }
    
    private var content: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.system(size: 12))
                .fontWeight(.semibold)
            options()
        }
    }
}

struct RoundedContainer<Content> : View where Content : View {
    
    private let content: Content
    
    init(_ content: Content) {
        self.content = content
    }
    
    var body: some View {
        let effect = VisualEffectView(material: .menu, blendingMode: .withinWindow)
        return content
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding(10)
            .background(effect)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.25), radius: 3.5, x: 0, y: 2)
    }
}
