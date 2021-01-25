//
// Created by Isaac Royo Raso on 24/1/21.
//

import SwiftUI

struct ControlsView: View {

    let viewModel: MainViewModel

    var body: some View {
        HStack(spacing: 0) {
            IconButton(icon: "arrow.clockwise", callback: viewModel.newWallpaper)
            Button(action: viewModel.applyWallpaper) {
                Text("Apply Wallpaper")
            }.buttonStyle(MaxWidthButtonStyle())
            IconButton(icon: "heart", callback: viewModel.saveWallpaper)
        }.padding()
    }

}

struct IconButton: View {

    let icon: String
    let callback: () -> Void

    var body: some View {
        Button(action: callback) {
            Image(systemName: icon)
                    .font(.system(size: 18))
        }.buttonStyle(PlainButtonStyle())
    }
}
