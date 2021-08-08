//
//  ContentView.swift
//  Shared
//
//  Created by Bjørn Kristian Teisrud on 31/07/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            Spacer()
            Spacer()
            Text("QuickFeed")
                .font(.system(.title, design: .monospaced))
                .fontWeight(.bold)
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
            HStack{
                Spacer()
                Image("GitHubLogo")
                    .resizable()
                    .frame(width: 18, height: 18)
                Text("Sign in with GitHub")
                Spacer()
            }
            .frame(height: 50)
            .background(Color("GitHubColor"))
            .foregroundColor(.white)
            .cornerRadius(10.0)
            .contentShape(Rectangle())
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
