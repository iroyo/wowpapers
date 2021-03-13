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
