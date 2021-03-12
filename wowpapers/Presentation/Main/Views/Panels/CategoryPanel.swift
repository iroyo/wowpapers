//
//  WallpaperDataCategory .swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 11/3/21.
//

import SwiftUI


struct CategoryPanel : View {
    
    let action: () -> Void
    
    var body: some View {
        WallpaperData(action: action) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Category").titlePanel()
                CategoryChip(name: "Ocean")
            }
        }
    }
}

struct CategoryChip : View {
    
    let name: String
    
    var body: some View {
        Text(name)
            .font(.system(size: 10))
            .fontWeight(.medium)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .foregroundColor(Color.white)
            .background(Color.accent)
            .cornerRadius(16)
    }
    
}
