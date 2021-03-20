//
//  SourcePanel.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 12/3/21.
//

import SwiftUI

struct SourcePanel: View {
    
    let onClick: () -> Void
    	
    var body: some View {
        WallpaperData(action: onClick) {
            HStack(spacing: 8) {
                Image("iconPexels")
                    .resizable()
                    .padding(2)
                    .frame(width: 32, height: 32)
                    .background(Color.accent)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text("Source").titlePanel()
                    Text("Pexels")
                }
            }
        }
    }
}
