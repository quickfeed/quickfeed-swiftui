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
        GeometryReader { geometry in
            HStack{
                UserInformation(viewModel: viewModel)
                    .frame(width: geometry.size.width * 0.30)
                    .padding(.trailing)
                Divider()
                UserEnrollments(viewModel: viewModel, selectedCourse: $selectedCourse)
                    .frame(width: geometry.size.width * 0.68)
            }
        }
        .frame(minWidth: 550, maxWidth: .infinity, minHeight: 200, maxHeight: .infinity)
        .padding()
        .navigationTitle("UserProfile")
    }
}

/*struct UserProfile_Previews: PreviewProvider {
 static var previews: some View {
 UserProfile()
 }
 }*/