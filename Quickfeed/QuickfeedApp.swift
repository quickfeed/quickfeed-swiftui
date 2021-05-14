//
//  QuickfeedApp.swift
//  Quickfeed
//

import SwiftUI
import AppKit

@main
struct QuickfeedApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .commands{
            SidebarCommands()
            TextEditingCommands()
            ToolbarCommands()
        }
    }
}
