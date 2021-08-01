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
                    newInformation = !newInformation
                }){
                    Text(newInformation ? "Done" : "Edit")
                        .foregroundColor(.blue)
                }
            }
            ScrollView{
                VStack{
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
                                .foregroundColor(newEnrollment ? .clear : .primary)
                        }
                        .disabled(newEnrollment)
                    }
                    if newEnrollment{
                        if viewModel.getCoursesForNewEnrollments() == nil || viewModel.getCoursesForNewEnrollments() == [] {
                            HStack{
                                Spacer()
                                Text("No more courses for enrollment")
                                Spacer()
                            }
                            .padding(.top)
                            Divider()
                        } else {
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
    }
}
