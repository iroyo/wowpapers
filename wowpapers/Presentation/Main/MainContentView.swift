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
                Image("pexels")
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .aspectRatio(16 / 9, contentMode: .fill)
                        .fixedSize(horizontal: false, vertical: true)
                        .clipShape(Clipper(.bottom))
                        .cornerRadius(8)
                Image("pexels")
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .aspectRatio(16 / 9, contentMode: .fill)
                        .fixedSize(horizontal: false, vertical: true)
                        .clipShape(Clipper(.top))
                        .cornerRadius(8)
            }
            UpdateButton()
        }.padding().frame(width: 320)
    }
}

struct WowContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
