//
//  WowContentView.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 13/1/21.
//

import SwiftUI

struct WowContentView: View {

    @State var isShown: Bool = false
    @StateObject var viewModel = WowViewModel()

    var body: some View {
        VStack {
            //if let photo = viewModel.photo {
            //    DefaultAsyncImage(photo.thumbnailSrc)
            //            .aspectRatio(16 / 9, contentMode: .fit)
            //            .frame(width: 380)
            //}
            ZStack(alignment: .center) {
                CircularProgress()
            }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .aspectRatio(16 / 9, contentMode: .fill)
                    .fixedSize(horizontal: false, vertical: true)
                    .background(Color.orange)
            Button("New Wallpaper") {
                isShown.toggle()
            }.padding()
            if isShown {
                Color.red.frame(height: 300)
            }
        }.frame(width: 380)
    }
}

struct WowContentView_Previews: PreviewProvider {
    static var previews: some View {
        WowContentView()
    }
}
