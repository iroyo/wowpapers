//
//  SourcePanel.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 12/3/21.
//

import SwiftUI

struct SourcePanel: View {
    
    let action: () -> Void
    	
    var body: some View {
        WallpaperData(action: action) {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}
