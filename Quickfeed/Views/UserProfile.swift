//
//  UserProfile.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 08/03/2021.
//

import SwiftUI

struct UserProfile: View {
    @ObservedObject var viewModel: UserViewModel
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "person.fill")
                    .data(url: URL(string: viewModel.user.avatarURL)!)
                    .cornerRadius(10)
                    //.clipShape(Circle())
                    //.padding(1.0)
                    .frame(width: 100, height: 100)
                    //.overlay(Circle().stroke(Color.secondary, lineWidth: 1))
                Text(viewModel.user.name)
                    .font(.title)
                    .fontWeight(.bold)
            }
            //TextField("User name (email address)", text: viewModel.user.name)
            
        }
    }
}

/*struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}*/
