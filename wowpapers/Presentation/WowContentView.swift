//
//  WowContentView.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 13/1/21.
//

import SwiftUI

struct WowContentView: View {

    @StateObject var viewModel = WowViewModel()

    var body: some View {
        VStack {
            AsyncImage("")
            switch viewModel.photoProvider {
            case .system: Text("System")
            case .external(let photo): Text(photo.photographer.name)
            }
            Button("New Wallpaper", action: viewModel.getNewWallpaper)
                    .frame(maxWidth: .infinity)
                    .padding()
        }
    }
}

struct WowContentView_Previews: PreviewProvider {
    static var previews: some View {
        WowContentView()
    }
}
