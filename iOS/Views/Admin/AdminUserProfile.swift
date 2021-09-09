//
//  AdminUserProfile.swift
//  QuickFeed (iOS)
//
//  Created by Bjørn Kristian Teisrud on 09/09/2021.
//

import SwiftUI

struct AdminUserProfile: View {
    @ObservedObject var viewModel: AdminViewModel
    
    @State var user: User
    
    var body: some View {
        VStack{
            Text(user.name != "" ? user.name : user.login)
                .font(.title)
                .fontWeight(.bold)
            ScrollView{
                VStack{
                    if user.id != viewModel.user.id {
                        HStack{
                            Text("Admin:")
                            Spacer()
                            Button(action: {
                                user = viewModel.updateUser(user: user)!
                            }, label: {
                                Text(user.isAdmin ? "Demote" : "Promote")
                            })
                            .foregroundColor(user.isAdmin ? .red : .blue)
                        }
                        .padding(.top)
                        Divider()
                    }
                    HStack{
                        Text("Email:")
                        Spacer()
                        Link(destination: URL(string: "mailto:" + user.email)!, label: {
                            Text(user.email)
                        })
                    }
                    .padding(.top)
                    Divider()
                    HStack{
                        Text("StudentID:")
                        Spacer()
                        Text(user.studentID)
                    }
                    .padding(.top)
                    Divider()
                    HStack{
                        Text("GitHub LogIn:")
                        Spacer()
                        Link(destination: URL(string: "https://www.github.com/" + user.login)!, label:{
                            Text(user.login)
                        })
                    }
                    .padding(.top)
                }
                .padding()
                if viewModel.getEnrollmentByUser(userID: user.id) != nil && viewModel.getEnrollmentByUser(userID: user.id) != [] {
                    Divider()
                    VStack{
                        Text("Enrollments")
                            .font(.title2)
                            .fontWeight(.bold)
                        ForEach(sortEnrollment(), id: \.self){ enrollment in
                            HStack{
                                Text(enrollment.course.code)
                                Spacer()
                                Text(translateUserStatus(status: enrollment.status))
                            }
                            .padding(.top)
                            Divider()
                        }
                    }
                    .padding()
                }
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
    
    func sortEnrollment() -> [Enrollment]{
        var courses = viewModel.getEnrollmentByUser(userID: user.id)!
        courses.sort { $0.course.code < $1.course.code }
        return courses
    }
}
