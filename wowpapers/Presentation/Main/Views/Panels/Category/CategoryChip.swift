//
//  CategoryChip.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 13/3/21.
//

import SwiftUI

struct CategoryText : View {
    
    private let size: CGFloat
    private let name: String
    
    init(name: String, size: CGFloat = 10) {
        self.name = name
        self.size = size
    }
    
    var body: some View {
        Text(name)
            .font(.system(size: size))
            .fontWeight(.medium)
            .foregroundColor(Color.white)
            .lineLimit(1)
    }
    
}

struct ClickableCategoryChip : View {
    
    let category: Query
    let onClick: (Query) -> Void
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "xmark")
                .font(Font.system(size: 10, weight: .bold, design: .default))
                .foregroundColor(.white)
            CategoryText(name: category.name.capitalized, size: 12)
        }.onTapGesture {
            onClick(category)
        }.chip()
    }
}
