//
//  CategoryConfiguration.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 12/3/21.
//

import SwiftUI

struct CategoryConfiguration: View {
    
    private let closeCallback: () -> Void
    
    @State private var scale: CGFloat = 0
    @State private var category: String = ""
    
    init(_ callback: @escaping () -> Void) {
        closeCallback = callback
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Category").titlePanel()
            CategoryChip(name: "Ocean")
            CategoryChip(name: "Meme")
            CategoryChip(name: "Yeye")
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
