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
                WallpaperOption($viewModel.state) { pair in
                    pair.first
                }.clipShape(Clipper(.bottom)).cornerRadius(8)
                WallpaperOption($viewModel.state) { pair in
                    pair.second
                }.clipShape(Clipper(.top)).cornerRadius(8)
            }
            UpdateButton(state: $viewModel.state, action: viewModel.newWallpaper)
        }.padding().frame(width: 320)
    }
}

struct WowContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
