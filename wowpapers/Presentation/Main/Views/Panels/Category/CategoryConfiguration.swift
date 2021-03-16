//
//  CategoryConfiguration.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 12/3/21.
//

import SwiftUI

struct CategoryConfiguration: View {
    
    private let closeCallback: () -> Void
    
    @State private var category: String = ""
    @State private var categories: [String] = []
    
    init(_ callback: @escaping () -> Void) {
        closeCallback = callback
    }
    
    var body: some View {
        ConfigurationBox(name: "Category", closeCallback) {
            Spacer().frame(height: 8)
            TextField("Add new category", text: $category)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(.vertical, 8)
            ForEach(categories, id: \.self) { name in
                Text(name)
            }

        }
    }
    
}
