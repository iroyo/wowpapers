//
//  WallpaperData.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 17/2/21.
//

import SwiftUI

struct WallpaperData: View {
    
    let result: WallpaperResults
    
    private var wallpaperSource: String {
        result.origin.rawValue
    }
    
    var body: some View {
        HStack {
            WallpaperSource(origin: wallpaperSource)
            Spacer()
            categoryLabel
        }
    }
    
    var categoryLabel: some View {
        Text(result.category)
            .padding(.vertical, 4)
            .padding(.trailing, 8)
            .padding(.leading, 16)
            .foregroundColor(Color.white)
            .background(Color.accentColor)
            .font(.system(size: 10))
            .cornerRadius(16)
            .overlay(
                Circle().frame(width: 6, height: 6).foregroundColor(Color.white).offset(x: 6, y: 0), alignment: .leading
            )
    }
}

struct WallpaperSource : View {
    
    let origin: String
    
    var body: some View {
        HStack(spacing: 2) {
            Text("from:")
            Text(origin)
                .fontWeight(.bold)
        }
        
    }
    
}
