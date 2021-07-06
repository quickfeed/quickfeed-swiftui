//
//  GitHubLogIn.swift
//  Quickfeed
//

import SwiftUI

struct GitHubLogInButton: View {
    @ObservedObject var viewModel: UserViewModel
    @Binding var login: Bool
    
    var body: some View {
        HStack{
            Spacer()
            Image("GitHubLogo")
                .resizable()
                .frame(width: 18, height: 18)
            Text("Sign in with GitHub")
            Spacer()
        }
        .frame(width: 250, height: 50)
        .background(Color("GitHubColor"))
        .foregroundColor(.white)
        .cornerRadius(10.0)
        .contentShape(Rectangle())
    }
}
