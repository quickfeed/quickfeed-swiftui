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
                if viewModel.remoteImage!.state == RemoteImageLoader.State.failure {
                    Image(systemName: "person.fill")
                        .resizable()
                        .cornerRadius(10)
                        .frame(width: 100, height: 100)
                } else {
                    Image(nsImage: NSImage(data: viewModel.remoteImage!.data)!)
                        .resizable()
                        .cornerRadius(10)
                        .frame(width: 100, height: 100)
                    
                }
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
