//
//  WallpaperData.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 11/3/21.
//

import SwiftUI

struct WallpaperData<Content> : View where Content : View {
    
    @State private var isHovering = false
    
    private let action: () -> Void
    private let content: () -> Content
    
    init(action: @escaping () -> Void, @ViewBuilder content: @escaping () -> Content) {
        self.action = action
        self.content = content
    }
    
    var body: some View {
        HStack {
            content()
            Spacer(minLength: 4)
            icon.opacity(isHovering ? 1 : 0)
        }
        .padding(10)
        .contentShape(Rectangle())
        .frame(maxWidth: .infinity)
        .onTapGesture(perform: action)
        .onHover { isHovering in
            self.isHovering = isHovering
        }
    }
    
    private var icon: some View {
        Image(systemName: "chevron.right")
            .font(.system(size: 12, weight: .bold, design: .rounded))
            .foregroundColor(Color.gray)
    }
    
}

extension Text {
    
    func titlePanel() -> some View {
        self
            .font(.system(size: 12))
            .fontWeight(.semibold)
    }
}
