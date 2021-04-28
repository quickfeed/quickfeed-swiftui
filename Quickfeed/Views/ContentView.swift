//
//  ContentView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 25/01/2021.
//

import SwiftUI
import AppKit

struct ContentView: View {
    @StateObject var viewModel: UserViewModel = UserViewModel()
    
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
            }
        }
    }
}
