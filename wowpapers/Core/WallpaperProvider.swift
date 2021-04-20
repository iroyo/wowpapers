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
    
    private let defaultExtension = "jpg"
    
    
    func applyWallpaper(from link: String) {
        if let url = URL(string: link) {
            let documentDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            URLSession.shared.downloadTask(with: url) { location, response, error in
                guard let location = location else {
                    return
                }
          
                do {
                    let extensionFile = response?.suggestedFilename?.components(separatedBy: ".").last ?? defaultExtension
                    let fileName = "photo-\(UUID().uuidString).\(extensionFile)"
                    let fileUrl = documentDir.appendingPathComponent(fileName)
                    try clearAllData(from: documentDir)
                    try FileManager.default.moveItem(at: location, to: fileUrl)
                    for screen in NSScreen.screens {
                        try NSWorkspace.shared.setDesktopImageURL(fileUrl, for: screen, options: [:])
                    }
                } catch {
                    print(error)
                }
                
            }.resume()
        }
    }
    
    private func clearAllData(from url: URL) throws {
        let urlFiles = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
        for urlFile in urlFiles {
            try FileManager.default.removeItem(at: urlFile)
        }
    }
    
    
}
