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
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                Text("Choose one option")
                    .fontWeight(.bold)
                    .padding(14)
                
                wallpaperChooser
                
                HStack(spacing: 12) {
                    buildPanel(type: .category) {
                        CategoryPanel(action: vm.openCategoryPanel)
                    }
                    buildPanel(type: .source) { 
                        SourcePanel(action: vm.openSourcePanel)
                    }
                }.padding(12)

            }
         
        }
        .frame(width: 320)
    }
    
    var wallpaperChooser: some View {
        ZStack {
            VStack(spacing: 16) {
                getWallpaperViewer(position: .top)
                getWallpaperViewer(position: .bottom)
            }
            WallpaperAction(isLoading: $vm.loading, action: vm.newWallpaper)
        }
    }
    
    @ViewBuilder
    private func buildPanel<Content : View>(type: MainViewModel.PanelType, @ViewBuilder content: @escaping () -> Content) -> some View {
        if vm.panelMode.isExpanded(for: type) {
            Color.clear.frame(maxWidth: .infinity)
        } else {
            content()
                .frame(height: 60)
                .roundedCard()
        }
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
