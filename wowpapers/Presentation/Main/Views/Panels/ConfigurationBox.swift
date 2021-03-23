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
    
    @State private var scale: CGFloat = 0
    
    init(name: String, @ViewBuilder content: @escaping () -> Content) {
        self.name = name
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name).titlePanel()
            content()
        }
        .padding(10)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    
    }
    
}
