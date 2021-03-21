//
//  WallpaperDataCategory .swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 11/3/21.
//

import SwiftUI


struct CategoryPanel : View {
    
    let onClick: () -> Void
    
    var body: some View {
        WallpaperData(action: onClick) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Category").titlePanel()
                CategoryText(name: "Ocean").chip()
            }
        }
    }
}
