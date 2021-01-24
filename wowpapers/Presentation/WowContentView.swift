//
//  WowContentView.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 13/1/21.
//

import SwiftUI

struct WowContentView: View {

    // "https://images.pexels.com/photos/1646311/pexels-photo-1646311.jpeg?auto=compress&cs=tinysrgb&h=350"
    // https://images.pexels.com/photos/2387869/pexels-photo-2387869.jpeg?auto=compress&cs=tinysrgb&h=350
    @State var isShown: Bool = false
    @StateObject var viewModel = WowViewModel()

    var body: some View {
        VStack {
            BasicAsyncImage("https://images.pexels.com/photos/2387869/pexels-photo-2387869.jpeg?auto=compress&cs=tinysrgb&h=350")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .aspectRatio(16 / 9, contentMode: .fill)
                    .fixedSize(horizontal: false, vertical: true)
            Button("Apply Wallpaper") {

            }.padding()
        }.frame(width: 380)
    }
}

struct WowContentView_Previews: PreviewProvider {
    static var previews: some View {
        WowContentView()
    }
}
