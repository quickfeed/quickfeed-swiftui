//
//  UserProfile.swift
//  QuickFeed (iOS)
//
//  Created by Bjørn Kristian Teisrud on 01/08/2021.
//

import SwiftUI

struct UserProfile: View {
    @ObservedObject var viewModel: UserViewModel
    
    @State var newInformation: Bool = false
    @State var newEnrollment: Bool = false
    
    @State private var userName: String = ""
    @State private var userEmail: String = ""
    @State private var userStudentID: String = ""
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    
                }){
                    Text(newInformation ? "Done" : "Edit")
                        .foregroundColor(.clear)
                }
                .disabled(true)
                Spacer()
                Text("UserProfile")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    viewModel.updateUser(name: userName, studentID: userStudentID, email: userEmail)
                    newInformation = !newInformation
                }){
                    Text(newInformation ? "Done" : "Edit")
                        .foregroundColor(newInformation && !(self.isValidEmail() && self.isValidStudentID() && self.isValidName()) ? .clear : .blue)
                }
                .disabled(newInformation && !(self.isValidEmail() && self.isValidStudentID() && self.isValidName()))
            }
            ScrollView{
                VStack{
                    if newInformation {
                        HStack{
                            Text("Enter Name:")
                            Spacer()
                            TextField("Enter your name...", text: $userName)
                                .foregroundColor(isValidName() ? .secondary : .red)
                        }
                        .padding(.top)
                        Divider()
                        HStack{
                            Text("Enter Email:")
                            Spacer()
                            TextField("Enter your Email...", text: $userEmail)
                                .foregroundColor(isValidEmail() ? .secondary : .red)
                        }
                        .padding(.top)
                        Divider()
                        HStack{
                            Text("Enter StudentID:")
                            Spacer()
                            TextField("Enter your studentID...", text: $userStudentID)
                                .foregroundColor(isValidStudentID() ? .secondary : .red)
                        }
                        .padding(.top)
                    } else {
                        HStack{
                            Text("Name:")
                            Spacer()
                            Text(viewModel.user!.name)
                        }
                        .padding(.top)
                        Divider()
                        HStack{
                            Text("Email:")
                            Spacer()
                            Text(viewModel.user!.email)
                        }
                        .padding(.top)
                        Divider()
                        HStack{
                            Text("StudentID:")
                            Spacer()
                            Text(viewModel.user!.studentID)
                        }
                        .padding(.top)
                    }
                }
                .padding()
                Divider()
                VStack(alignment: .leading){
                    HStack{
                        Button(action: {
                            newEnrollment = !newEnrollment
                        }){
                            Image(systemName: "chevron.backward")
                                .foregroundColor(newEnrollment ? .primary : .clear)
                        }
                        .disabled(!newEnrollment)
                        Spacer()
                        Text(newEnrollment ? "New Enrollments" : "Enrollments")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                        Button(action: {
                            newEnrollment = !newEnrollment
                        }){
                            Image(systemName: "plus")
                                .foregroundColor(newEnrollment || viewModel.getCoursesForNewEnrollments() == nil || viewModel.getCoursesForNewEnrollments() == [] ? .clear : .primary)
                        }
                        .disabled(newEnrollment || viewModel.getCoursesForNewEnrollments() == nil || viewModel.getCoursesForNewEnrollments() == [])
                    }
                    if newEnrollment{
                        
                        ForEach(viewModel.getCoursesForNewEnrollments()!, id: \.self){ course in
                            HStack{
                                Text(course.code)
                                Spacer()
                                Button(action: {
                                    viewModel.createEnrollment(courseID: course.id)
                                    newEnrollment = !newEnrollment
                                    viewModel.getEnrollments()
                                }){
                                    Text("Enroll")
                                }
                            }
                            .padding(.top)
                            Divider()
                        }
                        
                    }else{
                        ForEach(viewModel.enrollments, id: \.self){ enrollment in
                            HStack{
                                Text(enrollment.course.code)
                                Spacer()
                                Text(translateUserStatus(status: enrollment.status))
                            }
                            .padding(.top)
                            Divider()
                        }
                    }
                }
                .padding()
            }
        }
        .padding()
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
