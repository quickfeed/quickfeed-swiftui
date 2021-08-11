//
//  ContentView.swift
//  QuickFeed (iOS)
//
//  Created by Bjørn Kristian Teisrud on 31/07/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: UserViewModel = UserViewModel()
    
    var body: some View {
        if viewModel.user == nil {
            LogIn(viewModel: viewModel)
        } else {
            Navigation(viewModel: viewModel)
        }
    }
}
