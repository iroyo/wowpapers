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
    
    @Environment(\.factory) var factory: ViewModelFactory

    @StateObject var vm: MainViewModel
    @Namespace var nspace
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                Text("Choose one option")
                    .fontWeight(.bold)
                    .padding(14)
                
                wallpaperChooser
                
                if case let Resource.loaded(value) = vm.wallpapers {
                    wallpaperPanels(with: value).padding(12)
                } else {
                    HStack(spacing: 12) {
                        Color.clear.frame(height: 60).roundedCard()
                        Color.clear.frame(height: 60).roundedCard()
                    }.padding(12)
                }
            }
            
            if let type = vm.panelMode.expandedType() {
                Color.clear.contentShape(Rectangle()).onTapGesture {
                   callback(for: .close(type), animation: .scaleDown)()
                }
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
            return CategoryConfiguration(vm: factory.get(), closeCallback: closeCallback)
        default:
            return CategoryConfiguration(vm: factory.get(), closeCallback: closeCallback)
        }
        
    }
    
    private var wallpaperChooser: some View {
        ZStack {
            VStack(spacing: 16) {
                getWallpaperViewer(position: .top)
                getWallpaperViewer(position: .bottom)
            }
            WallpaperAction(
                shouldHover: vm.panelMode.isClosed(),
                isLoading: $vm.loading,
                action: vm.newWallpaper
            )
            if !vm.panelMode.isClosed() {
                Rectangle().fill(Color.white.opacity(0.25))
            }
        }.onAppear {
            vm.newWallpaper()
        }
    }
    
    private func wallpaperPanels(with result: WallpaperResults) -> some View {
        HStack(spacing: 12) {
            buildPanel(type: .category) { callback in
                CategoryPanel(query: result.category, onClick: callback)
            }
            buildPanel(type: .source) { callback in
                SourcePanel(source: result.origin, onClick: callback)
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
