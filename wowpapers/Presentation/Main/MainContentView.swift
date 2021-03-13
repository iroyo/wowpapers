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
                switch type {
                case .category:
                    CategoryConfiguration(closeCallback: closeModal)
                        .matchedGeometryEffect(id: type, in: nspace)
                        .zIndex(4)
                        .transition(.hero)
                case .source:
                    Text("source")
                }
            }
         
        }
        .frame(width: 320)
    }
    
    private func open(_ type: MainViewModel.PanelType) -> () -> Void {
        return {
            withAnimation(.scaleUp) { vm.panelMode = .expanded(type) }
        }
    }
    
    private func closeModal() {
        withAnimation(.scaleDown) {
            vm.panelMode = .closed
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
                CategoryPanel(onClick: open(.category))
            }
            buildPanel(type: .source) {
                SourcePanel(onClick: open(.source))
            }
        }
    }
    
    @ViewBuilder
    private func buildPanel<Content : View>(type: MainViewModel.PanelType, @ViewBuilder content: @escaping () -> Content) -> some View {
        if vm.panelMode.isExpanded(for: type) {
            Color.clear.frame(maxWidth: .infinity)
        } else {
            content()
                .matchedGeometryEffect(id: type, in: nspace)
                .transition(.invisible)
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
