//
//  UserProfile.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 08/03/2021.
//

import SwiftUI

struct UserProfile: View {
    @ObservedObject var viewModel: UserViewModel
    @Binding var selectedCourse: UInt64
    
    var body: some View {
        HStack{
            RemoteImage(url: viewModel.user.avatarURL)
                .cornerRadius(7.5)
                .frame(width: 50, height: 50)
            Text(viewModel.user.name)
                .font(.title)
                .fontWeight(.bold)
        }
        .padding()
        HStack{
            UserInformation(viewModel: viewModel)
            Divider()
            UserEnrollments(viewModel: viewModel, selectedCourse: $selectedCourse)
        }
        .padding()
        .navigationTitle("UserProfile")
        .toolbar{
            Image(systemName: "plus")
        }
    }
}

/*struct UserProfile_Previews: PreviewProvider {
 static var previews: some View {
 UserProfile()
 }
 }*/
