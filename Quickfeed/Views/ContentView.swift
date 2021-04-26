//
//  ContentView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 25/01/2021.
//

import SwiftUI
import AppKit

struct ContentView: View {
    @ObservedObject var viewModel: UserViewModel = UserViewModel()
    
    var body: some View {
        if viewModel.user == nil {
            LogIn(viewModel: viewModel)
        } else {
            if viewModel.user!.name == "" || viewModel.user!.email == "" || viewModel.user!.studentID == "" {
                NewUserProfile(viewModel: viewModel)
            } else if viewModel.courses == [] || viewModel.courses == nil{
                Text("New User Profile")
            }else {
                NavigatorView(viewModel: viewModel, selectedCourse: viewModel.courses![0].id)
                    .toolbar {
                        ToolbarItem(placement: .navigation) {
                            Button(action: toggleSidebar, label: {
                                Image(systemName: "sidebar.left")
                            })
                        }
                    }
            }
        }
    }
}



// NOTE: Hack to hide/show navigationbar
// Source: https://developer.apple.com/forums/thread/651807
private func toggleSidebar() {
    #if os(iOS)
    #else
    NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    #endif
}
