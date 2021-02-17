//
//  MainContentView.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 13/1/21.
//

import SwiftUI


struct MainContentView: View {

    @StateObject var viewModel = MainViewModel()

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                VStack(spacing: 16) {
                    WallpaperViewer(viewModel.aboveWallpaper)
                        .clipShape(Clipper(.below))
                        .cornerRadius(8)
                    WallpaperViewer(viewModel.belowWallpaper)
                        .clipShape(Clipper(.above))
                        .cornerRadius(8)
                }
                WallpaperAction(isLoading: $viewModel.loading, action: viewModel.newWallpaper)
            }
            if case let Resource.loaded(data) = viewModel.wallpapers {
                WallpaperData(result: data)
            }
            
        }
        .padding()
        .frame(width: 320)
    }
}

struct WowContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
