//
//  AppDelegate.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 13/1/21.
//

import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let popover = NSPopover.init()
    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.variableLength)
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        popover.contentViewController = NSHostingController(rootView: WowContentView())
        popover.contentSize = NSSize(width: 360, height: 320)
        popover.behavior = .transient
        popover.animates = false

        // Create the status item
        statusItem.button?.image = NSImage(named: "Icon")
        statusItem.button?.action = #selector(togglePopover)
    }
    
    @objc func togglePopover(_ sender: AnyObject?) {
        if let button = statusItem.button {
            if popover.isShown {
                popover.performClose(sender)
            } else {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            }
        }
    }

}

