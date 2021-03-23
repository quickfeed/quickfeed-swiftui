//
//  ContentView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 25/01/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: UserViewModel = UserViewModel(provider: ServerProvider())
    
    var body: some View {
        
        if viewModel.courses == nil {
            Text("FATAL ERROR! NO COURSES")
        } else {
            NavigatorView(viewModel: viewModel, selectedCourse: viewModel.courses![0].id)
                .navigationTitle("QuickFeed")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
