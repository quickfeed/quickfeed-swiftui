//
//  LogIn.swift
//  Quickfeed
//

import SwiftUI

struct LogIn: View {
    @ObservedObject var viewModel: UserViewModel
    @Binding var login: Bool
    @State var signingIn: Bool = false
    @State var hostName: String = "https://uis.itest.run/app/login/login/github"
    
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
            TextField("Hostname", text: $hostName)
            GitHubLogInButton(viewModel: viewModel, login: $login)
                .onTapGesture {
                    signingIn = true
                }
                .sheet(isPresented: $signingIn, content: {
                    AuthWebView(viewModel: viewModel, mesgURL: self.hostName)
                        .frame(width: 600, height: 600)
                })
            
            
        }
        .frame(width: 300, height: 300)
    }
}
