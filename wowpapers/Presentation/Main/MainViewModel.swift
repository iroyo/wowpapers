//
//  MainViewModel.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 13/1/21.
//

import Combine
import Foundation

class MainViewModel: ObservableObject {
    
    enum PanelType {
        case source, category
    }
    
    enum PanelMode {
        case closed
        case expanded(PanelType)
        
        func isClosed() -> Bool {
            switch self {
            case .closed: return true
            default: return false
            }
        }
                
        func isExpanded(for type: PanelType) -> Bool {
            switch self {
            case .expanded(let result):
                if case type = result {
                    return true
                } else {
                    return false
                }
            default: return false
            }
        }
    }
    
    private let provider: PhotoProvider = PhotoManager()

    @Published var loading: Bool = true
    @Published var panelMode: PanelMode = .closed
    @Published var wallpapers: Resource<WallpaperResults> = .waiting

    var aboveWallpaper: Resource<PhotoData> {
        wallpapers.map(\.options.0)
    }

    var belowWallpaper: Resource<PhotoData> {
        wallpapers.map(\.options.1)
    }

    init() {
        //newWallpaper()
    }
    
    func openCategoryPanel() {
        panelMode = .expanded(.category)
    }
    
    func openSourcePanel() {
        panelMode = .expanded(.source)
    }

    func newWallpaper() {
        provider.searchPhotoPair(from: "mountain")
            .onStart { self.loading = true }
            .onFinish { self.loading = false }
            .asResource()
            .assign(to: &self.$wallpapers)
    }

    func applyWallpaper(data: Photo) {
        print("applyWallpaper")
    }

}
