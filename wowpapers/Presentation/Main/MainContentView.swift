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
        ZStack {
            VStack(spacing: 16) {
                WallpaperOption(viewModel.aboveWallpaper)
                    .clipShape(Clipper(.below))
                    .cornerRadius(8)
                WallpaperOption(viewModel.belowWallpaper)
                    .clipShape(Clipper(.above))
                    .cornerRadius(8)
            }
            UpdateButton(isLoading: $viewModel.loading, action: viewModel.newWallpaper)
        }.padding().frame(width: 320)
    }
}

struct WowContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
