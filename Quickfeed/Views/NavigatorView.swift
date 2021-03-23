//
//  NavigatorView.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 26/02/2021.
//

import SwiftUI

struct NavigatorView: View {
    @ObservedObject var viewModel: UserViewModel
    var courses: [Course] { return viewModel.courses! }
    @State var selectedCourse: UInt64
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                
                CoursePicker(courses: courses, selectedCourse: $selectedCourse)
                    .padding([.horizontal, .top])
                
                if viewModel.isTeacherForCourse(courseId: selectedCourse)! {
                    TeacherNavigationView(viewModel: TeacherViewModel(provider: ServerProvider(), course: viewModel.getCourse(courseID: selectedCourse)!))
                } else {
                    StudentNavigatorView(viewModel: StudentViewModel(provider: ServerProvider(), course: viewModel.getCourse(courseID: selectedCourse)!))
                }
                
                Spacer()
                if viewModel.user.isAdmin{
                    NavigationLink(
                        destination: Admin(viewModel: AdminViewModel(provider: ServerProvider()), showUsers: false)){
                        HStack{
                            Image(systemName: "folder.badge.gear")
                                .frame(width: 30)
                                .padding(.leading)
                                .foregroundColor(.blue)
                            Text("Courses")
                                .font(.headline)
                            Spacer()
                        }
                        .contentShape(Rectangle())
                    }
                    .padding(.bottom, 1.0)
                    .buttonStyle(PlainButtonStyle())
                    NavigationLink(
                        destination: Admin(viewModel: AdminViewModel(provider: ServerProvider()))){
                        HStack{
                            Image(systemName: "person.2")
                                .frame(width: 30)
                                .padding(.leading)
                                .foregroundColor(.blue)
                            Text("Users")
                                .font(.headline)
                            Spacer()
                        }
                        .contentShape(Rectangle())
                    }
                    .padding(.vertical, 1.0)
                    .buttonStyle(PlainButtonStyle())
                }
                NavigationLink(
                    destination: UserProfile(viewModel: viewModel, selectedCourse: $selectedCourse)){
                    HStack{
                        RemoteImage(url: viewModel.user.avatarURL)
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
        })
    }
}

/*struct NavigatorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigatorView(viewModel: UserViewModel(provider: FakeProvider()))
    }
}*/
