//
//  LogInView.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 22/02/2021.
//

import SwiftUI

struct LogInView: View {
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

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
