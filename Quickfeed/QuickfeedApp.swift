//
//  QuickfeedApp.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 25/01/2021.
//

import SwiftUI
import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
    }
    
}


struct AppCommands: Commands {
    
    func action() {}
    func anotherAction() {}
    
    @CommandsBuilder var body: some Commands {
        CommandMenu("Menu") {
            Button(action: {
                action()
            }) {
                Text("Action")
            }
            .keyboardShortcut("s")
            Button(action: {
                anotherAction()
            }) {
                Text("Another action")
            }
        }
    }
}


@main
struct QuickfeedApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .commands{
            AppCommands()
            TextEditingCommands()
        }
    }
}
