//
//  QueryPanel.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 11/3/21.
//

import SwiftUI


struct QueryPanel : View {
    
    let query: String
    let onClick: () -> Void
    
    var body: some View {
        WallpaperData(action: onClick) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Query").titlePanel()
                QueryText(name: query).chip()
            }
        }
    }
}
