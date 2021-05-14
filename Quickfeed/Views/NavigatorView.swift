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
    @Binding var login: Bool
    @State private var activeDest: Int? = 1
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                
                if viewModel.courses != nil && viewModel.courses != []{
                    CoursePicker(courses: courses, selectedCourse: $selectedCourse)
                        .padding([.horizontal, .top])
                    
                    if viewModel.isTeacherForCourse(courseId: selectedCourse)! {
                        TeacherNavigationView(viewModel: TeacherViewModel(provider: ServerProvider.shared, course: viewModel.getCourse(courseID: selectedCourse)!))
                    } else {
                        StudentNavigatorView(viewModelTest: StudentViewModel.shared, course: viewModel.getCourse(courseID: selectedCourse)!)
                    }
                }
                
                Spacer()
                if viewModel.user!.isAdmin{
                    NavigationLink(
                        destination: AdminCourses(viewModel: AdminViewModel.shared), tag: 2, selection: $activeDest){
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
                        destination: AdminUsers(viewModel: AdminViewModel.shared), tag: 3, selection: $activeDest){
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
                if viewModel.courses == []{
                    NavigationLink(
                        destination: NewUserProfile(viewModel: viewModel, login: $login), tag: 1, selection: $activeDest){
                        HStack{
                            RemoteImage(url: viewModel.user!.avatarURL)
                                .cornerRadius(7.5)
                                .frame(width: 30, height: 30)
                                .padding(.leading)
                            Text(viewModel.user!.name)
                                .font(.headline)
                            Spacer()
                        }
                        .frame(height: 50)
                        .contentShape(Rectangle())
                    }
                    .padding(.top, 0.0)
                    .buttonStyle(PlainButtonStyle())
                } else{
                    NavigationLink(
                        destination: UserProfile(viewModel: viewModel, selectedCourse: $selectedCourse, login: $login), tag: 1, selection: $activeDest){
                        HStack{
                            RemoteImage(url: viewModel.user!.avatarURL)
                                .cornerRadius(7.5)
                                .frame(width: 30, height: 30)
                                .padding(.leading)
                            Text(viewModel.user!.name)
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
            .frame(minWidth: 200)
        }
    }
}
