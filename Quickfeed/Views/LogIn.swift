//
//  LogIn.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 29/03/2021.
//

import SwiftUI

struct LogIn: View {
    @ObservedObject var viewModel: UserViewModel
    @Binding var login: Bool
    
    var body: some View {
        
        VStack{
            Text("QuickFeed")
                .font(.system(.title, design: .monospaced))
                .fontWeight(.bold)
                .padding()
            HStack{
                VStack{
                    Divider()
                }
                Text("Log In")
                VStack{
                    Divider()
                }
            }
            .padding(.horizontal)
            GitHubLogIn(viewModel: viewModel, login: $login)
        }
        .frame(width: 300, height: 165)
        
    }
}
