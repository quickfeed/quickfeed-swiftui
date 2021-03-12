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
    
    init(viewModel: UserViewModel) {
        self.viewModel = viewModel
        self.viewModel.getRemoteImage()
    }
    
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
                        destination: Text("ADMIN")){
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
                    destination: UserProfile(viewModel: viewModel)){
                    HStack{
                            if viewModel.remoteImage!.state == RemoteImageLoader.State.failure {
                                Image(systemName: "person.fill")
                                    .cornerRadius(7.5)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading)
                            } else {
                                Image(nsImage: NSImage(data: viewModel.remoteImage!.data)!)
                                    .cornerRadius(7.5)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading)
                            }
                        /*Image(systemName: "person.fill")
                            .data(url: URL(string: viewModel.user.avatarURL)!)
                            .cornerRadius(7.5)
                            .frame(width: 30, height: 30)
                            .padding(.leading)*/
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
            viewModel.getRemoteImage()
        })
    }
}

struct NavigatorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigatorView(viewModel: UserViewModel(provider: FakeProvider()))
    }
}
