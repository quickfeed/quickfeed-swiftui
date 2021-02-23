//
//  GitHubLogIn.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 23/02/2021.
//

import SwiftUI

struct GitHubLogIn: View {
    var body: some View {
        HStack{
            Spacer()
            Image("GitHubLogo")
                .resizable()
                .frame(width: 18, height: 18)
            Text("Log in with GitHub")
            Spacer()
        }
        .frame(width: 250, height: 50)
        .background(Color("GitHubColor"))
        .foregroundColor(.white)
        .cornerRadius(10.0)
        .contentShape(Rectangle())
        .onTapGesture {
            print("Show details for user")
        }
    }
}

struct GitHubLogIn_Previews: PreviewProvider {
    static var previews: some View {
        GitHubLogIn()
    }
}
