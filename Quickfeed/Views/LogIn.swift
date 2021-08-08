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
            Spacer()
            Spacer()
            Text("QuickFeed")
                .font(.system(size: 35, design: .monospaced))
                .fontWeight(.bold)
                .padding()
            Spacer()
            Spacer()
            HStack{
                VStack{
                    Divider()
                }
                Text("Sign In")
                VStack{
                    Divider()
                }
            }
            .frame(width: 290)
            .padding(.horizontal)
            GitHubLogIn(viewModel: viewModel, login: $login)
        }
        .padding()
        .fill()
        .frame(minWidth: 300, minHeight: 200)
    }
}
