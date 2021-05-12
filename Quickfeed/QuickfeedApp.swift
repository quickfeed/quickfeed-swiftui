//
//  QuickfeedApp.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 25/01/2021.
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
