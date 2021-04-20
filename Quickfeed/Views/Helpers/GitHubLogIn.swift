//
//  GitHubLogIn.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 23/02/2021.
//

import SwiftUI

struct GitHubLogIn: View {
    @ObservedObject var viewModel: UserViewModel
    
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
        .onTapGesture {
            GitHubManager().logInWithGitHub()
        }
    }
}
