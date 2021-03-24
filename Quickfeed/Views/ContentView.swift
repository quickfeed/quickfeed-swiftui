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
<<<<<<< HEAD

        NavigatorView(viewModel: UserViewModel(provider: ServerProvider()))
            .navigationTitle("QuickFeed")
        
=======
        
        if viewModel.courses?.count == 0 {
            Text("FATAL ERROR! NO COURSES")
        } else {
            NavigatorView(viewModel: viewModel, selectedCourse: viewModel.courses![0].id)
                .navigationTitle("QuickFeed")
        }
>>>>>>> 6c4742e3e087e72e332d7e1fcd4a04c1e2cad21c
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
