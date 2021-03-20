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

    private lazy var monitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown], handler: mouseEventHandler)

    private let popover = NSPopover()
    private let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    private let controller = PersistenceController.shared
    
    private let di: DependencyProvider
    
    override init() {
        di = DependencyProvider(context: self.controller.container.viewContext)
    }

    func applicationDidFinishLaunching(_ notification: Notification) {
        let viewModel = MainViewModel(photoProvider: di.photoProvider, queryProvider: di.queryProvider)
        let view = MainContentView(vm: viewModel)
        
        popover.contentViewController = NSHostingController(rootView: view)
        popover.contentSize = NSSize(width: 320, height: 360)
        popover.behavior = .transient
        popover.animates = false

        // Create the status item
        statusItem.button?.image = NSImage(named: "Icon")
        statusItem.button?.action = #selector(togglePopover)
    }

    @objc func togglePopover(_ sender: AnyObject?) {
        if popover.isShown {
            closePopover(sender)
        } else {
            openPopover()
        }
    }

    private func openPopover() {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            popover.focus()
            monitor.start()
        }
    }

    private func closePopover(_ sender: AnyObject?) {
        popover.performClose(sender)
        monitor.stop()
    }

    private func mouseEventHandler(_ event: NSEvent?) {
        if popover.isShown  {
            closePopover(event)
        }
    }

}

extension NSPopover {

    func focus() {
        contentViewController?.view.window?.becomeKey()
    }

}

