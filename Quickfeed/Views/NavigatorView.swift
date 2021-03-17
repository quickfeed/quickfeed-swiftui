//
//  NavigatorView.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 26/02/2021.
//

import SwiftUI

struct NavigatorView: View {
    @ObservedObject var viewModel: UserViewModel
    var courses: [Course] { return viewModel.courses }
    @State private var selectedCourse: UInt64 = 0
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                
                CoursePicker(courses: courses, selectedCourse: $selectedCourse)
                    .padding([.horizontal, .top])
    
                if viewModel.getCourse(courseId: selectedCourse).enrolled == Enrollment.UserStatus.teacher {
                    TeacherNavigationView(viewModel: TeacherViewModel(provider: ServerProvider(), course: viewModel.getCourse(courseId: selectedCourse)))
                } else if viewModel.getCourse(courseId: selectedCourse).enrolled == Enrollment.UserStatus.student{
                    StudentNavigatorView(viewModel: StudentViewModel(provider: ServerProvider(), course: viewModel.getCourse(courseId: selectedCourse)))
                } else{
                    Text("Log in")
                }
                
                Spacer()
                if viewModel.user.isAdmin{
                    NavigationLink(
                        destination: AdminUsers(viewModel: AdminViewModel(provider: ServerProvider()))){
                        HStack{
                            Image(systemName: "folder.badge.gear")
                                .frame(width: 30)
                                .padding(.leading)
                                .foregroundColor(.blue)
                            Text("Admin")
                                .font(.headline)
                            //.padding(.leading)
                            Spacer()
                        }
                        //.frame(height: 30)
                        .contentShape(Rectangle())
                    }
                    .padding(.bottom, 0.0)
                    .buttonStyle(PlainButtonStyle())
                }
                NavigationLink(
                    destination: UserProfile(viewModel: viewModel, selectedCourse: $selectedCourse)){
                    HStack{
                            Image(systemName: "person.fill")
                                .cornerRadius(7.5)
                                .frame(width: 30, height: 30)
                                .padding(.leading)
                        Text(viewModel.user.name)
                            .font(.headline)
                        Spacer()
                    }
                    .frame(height: 50)
                    .contentShape(Rectangle())
                }
                .padding(.top, 0.0)
                .buttonStyle(PlainButtonStyle())
            }
            
        }
        .onAppear(perform: {
            self.selectedCourse = self.courses[0].id
            viewModel.getEnrollments()
        })
    }
}

struct NavigatorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigatorView(viewModel: UserViewModel(provider: FakeProvider()))
    }
}
