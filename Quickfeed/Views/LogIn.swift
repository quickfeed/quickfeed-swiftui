//
//  LogIn.swift
//  Quickfeed
//

import SwiftUI

struct LogIn: View {
    @ObservedObject var viewModel: UserViewModel
    @Binding var login: Bool
    @State var signingIn: Bool = false
    @State var authUrl: String = "https://\(baseURL)/app/login/login/github"
    @State var hasSession: Bool = false
    
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
            TextField("Hostname", text: $authUrl)
            GitHubLogInButton(viewModel: viewModel, login: $login)
                .onTapGesture {
                    signingIn = true
                }
                .sheet(isPresented: $signingIn, content: {
                    AuthWebView(viewModel: viewModel,
                                mesgURL: authUrl,
                                signingIn: $signingIn,
                                hasSession: $hasSession
                    )
                    .frame(width: 600, height: 600)
                })
                .onChange(of: self.hasSession, perform: { value in
                    signingIn = false
                    print(hasSession)
                    
                    
                })
            
            
            
        }
        
        .frame(width: 300, height: 300)
        
    }
}
