//
//  ConfigurationBox.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 16/3/21.
//

import SwiftUI

struct ConfigurationBox<Content> : View where Content : View {
    
    private let name: String
    private let content: () -> Content
    private let closeCallback: () -> Void
    
    @State private var scale: CGFloat = 0
    
    init(name: String, _ closeCallback: @escaping () -> Void,  @ViewBuilder content: @escaping () -> Content) {
        self.name = name
        self.content = content
        self.closeCallback = closeCallback
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name).titlePanel()
            content()
        }
        .padding(10)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .overlay(closeButton, alignment: .topTrailing)
        .onAppear {
            withAnimation(Animation.spring().delay(0.65)) {
                scale = 1
            }
        }
    }
    
    private var closeButton: some View {
        Button(action: {
            withAnimation(Animation.easeOut(duration: 0.15)) { scale = 0 }
            closeCallback()
        }, label: {
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(Color.gray)
                .padding(10)
                .contentShape(Rectangle())
        })
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(scale)
    }
}
