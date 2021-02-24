//
//  MainContentView.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 13/1/21.
//

import SwiftUI


struct MainContentView: View {
    
    private enum ViewerPosition {
        case top, bottom
    }

    @StateObject var vm = MainViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Choose one option")
                .fontWeight(.bold)
                .padding(14)
            ZStack {
                VStack(spacing: 16) {
                    getWallpaperViewer(position: .top)
                    getWallpaperViewer(position: .bottom)
                }
                WallpaperAction(isLoading: $vm.loading, action: vm.newWallpaper)
            }
            if case let Resource.loaded(data) = vm.wallpapers {
                WallpaperData(result: data).padding()
            }
            
        }
        .frame(width: 320)
    }
    
    private func getWallpaperViewer(position: ViewerPosition) -> WallpaperViewer {
        var result: (data: Resource<PhotoData>, configuration: CutConfiguration) {
            switch position {
            case .top: return (vm.aboveWallpaper, .below)
            case .bottom: return (vm.belowWallpaper, .above)
            }
        }
        return WallpaperViewer(
            result.data,
            cut: result.configuration,
            onClick: vm.applyWallpaper
        )
    }
}

struct WowContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
