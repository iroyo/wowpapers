//
//  Colors.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 20/1/21.
//

import SwiftUI

extension Color {

    init(hex: String) {
        let r, g, b: Double

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = Double((hexNumber & 0xff000000) >> 24) / 255
                    g = Double((hexNumber & 0x00ff0000) >> 16) / 255
                    b = Double((hexNumber & 0x0000ff00) >> 8) / 255
                    self.init(red: r, green: g, blue: b)
                    return
                }
            }
        }

        self.init(red: 0, green: 0, blue: 0)
        return
    }
    
    static let primary = Color("colorPrimary")
    static let surface = Color("colorSurface")
    
}
