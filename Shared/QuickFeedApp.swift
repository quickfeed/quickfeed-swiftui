//
//  QuickFeedApp.swift
//  Shared
//
//  Created by Bjørn Kristian Teisrud on 31/07/2021.
//

import SwiftUI

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
