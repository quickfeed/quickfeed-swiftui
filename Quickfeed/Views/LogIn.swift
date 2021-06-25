//
//  LogIn.swift
//  Quickfeed
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
                Text("Sign In")
                VStack{
                    Divider()
                }
            }
            .padding(.horizontal)
            GitHubLogIn(viewModel: viewModel, login: $login)
            AuthWebView(mesgURL: "https://uis.itest.run")
        }
        .frame(width: 500, height: 500)
    }
}
