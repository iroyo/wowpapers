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

    @Namespace var nspace
    @StateObject var vm = MainViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                Text("Choose one option")
                    .fontWeight(.bold)
                    .padding(14)
                
                wallpaperChooser
                wallpaperPanels.padding(12)
            }
            
            if let type = vm.panelMode.expandedType() {
                ZStack {
                    extendedPanel(type).roundedCard()
                }
                .matchedGeometryEffect(id: type, in: nspace)
                .transition(.invisible)
                .frame(height: 120)
                .zIndex(4)
            }
         
        }
        .frame(width: 320)
    }
    
    private func callback(for mode: MainViewModel.PanelMode, animation: Animation) -> () -> Void {
        return {
            withAnimation(animation) { vm.panelMode = mode }
        }
    }
    
    private func extendedPanel(_ type: MainViewModel.PanelType) -> some View {
        let closeCallback = callback(for: .close(type), animation: .scaleDown)
        switch type {
        case MainViewModel.PanelType.category:
            return CategoryConfiguration(closeCallback)
        default:
            return CategoryConfiguration(closeCallback)
        }
        
    }
    
    private var wallpaperChooser: some View {
        ZStack {
            VStack(spacing: 16) {
                getWallpaperViewer(position: .top)
                getWallpaperViewer(position: .bottom)
            }
            WallpaperAction(isLoading: $vm.loading, action: vm.newWallpaper)
        }
    }
    
    private var wallpaperPanels: some View {
        HStack(spacing: 12) {
            buildPanel(type: .category) {
                CategoryPanel(onClick: callback(for: .expanded(.category), animation: .scaleUp))
            }
            buildPanel(type: .source) {
                SourcePanel(onClick: callback(for: .expanded(.source), animation: .scaleUp))
            }
        }
    }
    
    @ViewBuilder
    private func buildPanel<Content : View>(type: MainViewModel.PanelType, @ViewBuilder content: @escaping () -> Content) -> some View {
        if vm.panelMode.isExpanded(for: type) {
            Color.clear.frame(maxWidth: .infinity)
        } else {
            ZStack {
                content().roundedCard()
            }
            .matchedGeometryEffect(id: type, in: nspace)
            .transition(.hero)
            .frame(height: 60)
            .zIndex(getIndex(type))
        }
    }
    
    private func getIndex(_ type: MainViewModel.PanelType) -> Double {
        switch vm.panelMode {
        case .expanded(_):
            return 1.0
        case .close(let value):
            if let closedType = value {
                return closedType == type ? 4.0 : 2.0
            } else {
                return 2.0
            }
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
