//
//  LogIn.swift
//  Quickfeed
//

import SwiftUI

struct LogIn: View {
    @ObservedObject var viewModel: UserViewModel
    @Binding var login: Bool
    @State var signingIn: Bool = false
    @State var signedIn: Bool = false
    @State var authUrl: String = "https://\(CONF_BASE_URL)/app/login/login/github"
   
    
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
                                signedIn: $signedIn
                    )
                    .frame(width: 600, height: 600)
                })
        }
        .onChange(of: signedIn, perform: { data in
            viewModel.getUser()
        })
        
        .frame(width: 300, height: 300)
        
    }
}
