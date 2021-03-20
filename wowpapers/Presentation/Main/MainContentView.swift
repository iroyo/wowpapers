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

    @StateObject var vm: MainViewModel
    @Namespace var nspace
    
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
                Rectangle().fill(Color.clear)
                ZStack {
                    extendedPanel(type).roundedCard()
                }
                .matchedGeometryEffect(id: type, in: nspace)
                .transition(.invisible)
                .frame(height: 180)
                .zIndex(4)
            }
         
        }
        .frame(width: 320)
    }
    
    private func callback(for mode: PanelMode, animation: Animation) -> () -> Void {
        return {
            withAnimation(animation) { vm.panelMode = mode }
        }
    }
    
    private func extendedPanel(_ type: PanelType) -> some View {
        let closeCallback = callback(for: .close(type), animation: .scaleDown)
        switch type {
        case PanelType.category:
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
            buildPanel(type: .category) { callback in
                CategoryPanel(onClick: callback)
            }
            buildPanel(type: .source) { callback in
                SourcePanel(onClick: callback)
            }
        }
    }
    
    @ViewBuilder
    private func buildPanel<Content : View>(type: PanelType, @ViewBuilder content: @escaping (@escaping () -> Void) -> Content) -> some View {
        if vm.panelMode.isExpanded(for: type) {
            Color.clear.frame(maxWidth: .infinity)
        } else {
            ZStack {
                content(callback(for: .expanded(type), animation: .scaleUp)).roundedCard()
            }
            .matchedGeometryEffect(id: type, in: nspace)
            .transition(.hero)
            .frame(height: 60)
            .zIndex(getIndex(type))
        }
    }
    
    private func getIndex(_ type: PanelType) -> Double {
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
            shouldHover: vm.panelMode.isClosed(),
            cut: result.configuration,
            data: result.data,
            onClick: vm.applyWallpaper
        )
    }
}
