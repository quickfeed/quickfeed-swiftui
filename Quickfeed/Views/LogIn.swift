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
            Text("QuickFeed")
                .font(.system(.title, design: .monospaced))
                .fontWeight(.bold)
                .padding()
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
            .padding(.horizontal)
            Spacer()
            GitHubLogIn(viewModel: viewModel, login: $login)
            Spacer()
        }
         .fill()
         .frame(minWidth: 300, minHeight: 165)
    }
}
