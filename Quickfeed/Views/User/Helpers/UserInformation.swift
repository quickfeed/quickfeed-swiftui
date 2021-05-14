//
//  UserInformation.swift
//  Quickfeed
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
            HStack{
                Spacer()
                Text("User Information")
                    .font(.title2)
                    .bold()
                    .padding(.bottom)
                Spacer()
            }
            if isEditingUser {
                Text("Name:")
                    .bold()
                TextField("Enter your name...", text: $userName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(isValidName() ? .primary : .red)
                    .padding(.leading)
                Text("Email:")
                    .bold()
                TextField("Enter your Email...", text: $userEmail)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(isValidEmail() ? .primary : .red)
                    .padding(.leading)
                Text("StudentID:")
                    .bold()
                TextField("Enter your studentID...", text: $userStudentID)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(isValidStudentID() ? .primary : .red)
                    .padding(.leading)
            } else {
                Text("Name:")
                    .bold()
                TextField("Enter your name...", text: $userName)
                    .textFieldStyle(PlainTextFieldStyle())
                    .disabled(true)
                    .foregroundColor(.primary)
                    .padding(.leading)
                Text("Email:")
                    .bold()
                TextField("Enter your Email...", text: $userEmail)
                    .textFieldStyle(PlainTextFieldStyle())
                    .disabled(true)
                    .foregroundColor(.primary)
                    .padding(.leading)
                Text("StudentID:")
                    .bold()
                TextField("Enter your studentID...", text: $userStudentID)
                    .textFieldStyle(PlainTextFieldStyle())
                    .disabled(true)
                    .foregroundColor(.primary)
                    .padding(.leading)
            }
            if isEditingUser {
                if self.isValidEmail() && self.isValidStudentID() && self.isValidName(){
                    Button(action: {
                        viewModel.updateUser(name: userName, studentID: userStudentID, email: userEmail)
                        self.isEditingUser = false
                    }, label: {
                        Text("Done")
                    })
                }
            }else {
                Button(action: {
                    self.isEditingUser = true
                }, label: {
                    Text("Edit")
                })
            }
            Spacer()
        }
        .onAppear(perform: {
            self.userName = viewModel.user!.name
            self.userEmail = viewModel.user!.email
            self.userStudentID = viewModel.user!.studentID
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
