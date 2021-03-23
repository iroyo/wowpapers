//
//  SourcePanel.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 12/3/21.
//

import SwiftUI

struct SourcePanel: View {
    
    let source: Origin
    let onClick: () -> Void
    	
    var body: some View {
        WallpaperData(action: onClick) {
            HStack(spacing: 8) {
                Image(source.icon)
                    .resizable()
                    .padding(4)
                    .frame(width: 38, height: 38)
                    .background(Color.accent)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text("Source").titlePanel()
                    Text(source.rawValue)
                }
            }
        }
    }
}
