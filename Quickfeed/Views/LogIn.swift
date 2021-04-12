//
//  LogIn.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 29/03/2021.
//

import SwiftUI

struct LogIn: View {
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
                Text("Log In")
                VStack{
                    Divider()
                }
            }
            .padding(.horizontal)
            GitHubLogIn()
        }
        .frame(width: 300, height: 165)
        
    }
}

struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        LogIn()
    }
}
