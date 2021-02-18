//
//  WallpaperData.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 17/2/21.
//

import SwiftUI

struct WallpaperData: View {
    
    let result: WallpaperResults
    let state: MainViewModel.FooterData
    
    private var source: String {
        result.origin.rawValue
    }
    
  
    var body: some View {
        HStack(spacing: 2) {
            Text("from:")
            fromLabel
            Spacer()
            categoryLabel
        }
    }
    
    @ViewBuilder
    var fromLabel: some View {
        switch state {
        case .none:
            Text(source).fontWeight(.bold)
        case .selected(let data):
            Text(data.photographer.name).fontWeight(.bold)
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
