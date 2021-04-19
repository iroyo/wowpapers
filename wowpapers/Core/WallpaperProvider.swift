//
//  WallpaperProvider.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 19/4/21.
//

import AppKit
import Foundation

protocol WallpaperProvider {
    
    func applyWallpaper(from link: String)
    
}

struct WallpaperManager : WallpaperProvider {
    
    func applyWallpaper(from link: String) {
        if let url = URL(string: link) {
            let cacheDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            URLSession.shared.downloadTask(with: url) { location, response, error in
                guard let location = location else {
                    return
                }

                if let screen = NSScreen.main {
                    do {
                        let fileUrl = cacheDir.appendingPathComponent((UUID().uuidString))
                        try FileManager.default.moveItem(atPath: location.path, toPath: fileUrl.path)
                        try NSWorkspace.shared.setDesktopImageURL(fileUrl, for: screen, options: [:])
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    
}
