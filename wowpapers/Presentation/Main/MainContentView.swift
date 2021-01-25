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
        VStack(spacing: 0) {
            NavigationView()
            WallpaperView()
            ControlsView(viewModel: viewModel)
        }.frame(width: 380)
    }
}

struct WowContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
