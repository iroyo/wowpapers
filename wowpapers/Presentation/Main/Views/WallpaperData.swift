//
//  WallpaperData.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 17/2/21.
//

import SwiftUI

struct WallpaperData: View {
    
    let result: WallpaperResults
    
    private var source: String {
        result.origin.rawValue
    }
    
  
    var body: some View {
        HStack(spacing: 2) {
            sourceLabel
            Spacer()
            categoryLabel
        }
    }
    
   
    var sourceLabel: some View {
        HStack(spacing: 2) {
            Text("from:")
            Text(source).fontWeight(.bold)
        }
    }
    
    var categoryLabel: some View {
        Text(result.category)
            .font(.system(size: 10))
            .fontWeight(.medium)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .foregroundColor(Color.white)
            .background(Color.accent)
            .cornerRadius(16)
    }
}
