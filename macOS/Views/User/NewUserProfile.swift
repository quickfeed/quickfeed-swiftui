//
//  NewUserProfile.swift
//  Quickfeed
//

import SwiftUI

struct NewUserProfile: View {
    @ObservedObject var viewModel: UserViewModel
    @Binding var login: Bool

    var body: some View {
        HStack{
            RemoteImage(url: viewModel.user!.avatarURL)
                .cornerRadius(7.5)
                .frame(width: 50, height: 50)
            Text(viewModel.user!.name)
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
                NewUserEnrollments(viewModel: viewModel)
                    .frame(width: geometry.size.width * 0.68)
            }
        }
        .frame(minWidth: 550, maxWidth: .infinity, minHeight: 230, maxHeight: .infinity)
        .padding()
        .navigationTitle("UserProfile")
        .toolbar{
            Button(action: {login = !login}, label: Text("Sign Out"))
                .foregroundColor(.red)
        }
    }
}
