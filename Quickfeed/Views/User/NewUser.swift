//
//  NewUser.swift
//  Quickfeed
//

import SwiftUI

struct NewUser: View {
    @ObservedObject var viewModel: UserViewModel
    @State private var userName: String = ""
    @State private var userEmail: String = ""
    @State private var userStudentID: String = ""
    
    var body: some View {
        VStack{
            Spacer()
            VStack(alignment: .leading){
                HStack{
                    Spacer()
                    Text("User Information")
                        .font(.title2)
                        .bold()
                        .padding(.bottom)
                    Spacer()
                }
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
                if self.isValidEmail() && self.isValidStudentID() && self.isValidName() {
                    Button(action: {
                        viewModel.updateUser(name: self.userName, studentID: self.userStudentID, email: self.userEmail)
                    }, label: {
                        Text("Done")
                    })
                    .padding(.top)
                }
                Spacer()
            }
            .frame(width: 300, height: 250)
            .padding()
            Spacer()
            Spacer()
        }
        .fill()
        .frame(minWidth: 310, minHeight: 265)
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
