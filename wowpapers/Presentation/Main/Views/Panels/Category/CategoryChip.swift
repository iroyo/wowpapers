//
//  CategoryChip.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 13/3/21.
//

import SwiftUI

struct CategoryChip : View {
    
    private let name: String
    private let callback: (String) -> Void
    
    init(name: String, callback: @escaping (String) -> Void = {_ in}) {
        self.name = name
        self.callback = callback
    }
    
    var body: some View {
        Text(name)
            .font(.system(size: 10))
            .fontWeight(.medium)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .foregroundColor(Color.white)
            .background(Color.accent)
            .cornerRadius(16)
            .onTapGesture {
                callback(name)
            }
    }
    
}
