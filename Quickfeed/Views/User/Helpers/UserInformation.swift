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
                .font(.title2)
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
            if isEditingUser {
                Button(action: {
                    viewModel.updateUser(name: userName, studentID: userStudentID, email: userEmail)
                    self.isEditingUser = false
                }, label: {
                    Text("Done")
                })
                .disabled(!self.isValidEmail() || !self.isValidStudentID() || !self.isValidName())
            } else {
                Button(action: {
                    self.isEditingUser = true
                }, label: {
                    Text("Edit")
                })
            }
            Spacer()
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .onAppear(perform: {
            self.userName = viewModel.user.name
            self.userEmail = viewModel.user.email
            self.userStudentID = viewModel.user.studentID
        })
    }
    
    func isValidName() -> Bool {
        return self.userName.replacingOccurrences(of: " ", with: "").allSatisfy{ $0.isLetter }
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self.userEmail)
    }
    
    func isValidStudentID() -> Bool {
        return self.userStudentID.allSatisfy{ $0.isNumber } && !self.userStudentID.isEmpty
    }
}

/*struct UserInformation_Previews: PreviewProvider {
    static var previews: some View {
        UserInformation()
    }
}*/
