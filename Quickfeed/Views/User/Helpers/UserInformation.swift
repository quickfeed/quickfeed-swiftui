//
//  UserInformation.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 23/03/2021.
//

import SwiftUI

struct UserInformation: View {
    @ObservedObject var viewModel: UserViewModel
    @State private var userName: String = ""
    @State private var userEmail: String = ""
    @State private var userStudentID: String = ""
    @State private var isEditingUser: Bool = false
    
    var body: some View {
        VStack(alignment: .leading){
            Text("User Information")
                .font(.title)
                .bold()
                .padding(.bottom)
            if isEditingUser {
                Text("Name:")
                    .bold()
                TextField("Enter your name...", text: $userName)
                Text("Email:")
                    .bold()
                TextField("Enter your Email...", text: $userEmail)
                Text("StudentID:")
                    .bold()
                TextField("Enter your studentID...", text: $userStudentID)
            } else {
                Text("Name:")
                    .bold()
                Text(userName)
                Text("Email:")
                    .bold()
                Text(userEmail)
                Text("StudentID:")
                    .bold()
                Text(userStudentID)
            }
            Button(action: {
                viewModel.updateUser(name: userName, studentID: userStudentID, email: userEmail)
            }, label: {
                Text("Submit")
            })
            Toggle(isOn: $isEditingUser, label: {
                Text(isEditingUser ? "Submit" : "Edit")
            })
            Spacer()
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .onAppear(perform: {
            self.userName = viewModel.user.name
            self.userEmail = viewModel.user.email
            self.userStudentID = viewModel.user.studentID
        })
    }
}

/*struct UserInformation_Previews: PreviewProvider {
    static var previews: some View {
        UserInformation()
    }
}*/
