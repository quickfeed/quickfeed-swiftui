//
//  ContentView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 25/01/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: UserViewModel = UserViewModel(provider: ServerProvider.shared)
    
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
