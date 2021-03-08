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
    @State var selectedCourse: UInt64
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                CoursePicker(courses: courses, selectedCourse: $selectedCourse)
                    .padding([.horizontal, .top])
                if viewModel.getCourse(courseId: selectedCourse).enrolled == Enrollment.UserStatus.teacher {
                    TeacherNavigationView(viewModel: TeacherViewModel(provider: ServerProvider(), course: viewModel.getCourse(courseId: selectedCourse)))
                } else {
                    StudentNavigatorView(viewModel: StudentViewModel(provider: ServerProvider(), course: viewModel.getCourse(courseId: selectedCourse)))
                }
                Spacer()
                NavigationLink(
                    destination: UserProfile(viewModel: viewModel)){
                    HStack{
                        Image(systemName: "person.fill")
                            .data(url: URL(string: viewModel.user.avatarURL)!)
                            //.clipShape(Circle())
                            .frame(width: 30, height: 30)
                            .padding(.leading)
                        Text(viewModel.user.name)
                            .font(.headline)
                        Spacer()
                    }
                    .frame(height: 50)
                    .contentShape(Rectangle())
                }
                .buttonStyle(PlainButtonStyle())
            }
            
        }
        .onAppear(perform: {
            self.selectedCourse = self.courses[0].id
        })
    }
}

struct NavigatorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigatorView(viewModel: UserViewModel(provider: FakeProvider()), selectedCourse: 111)
    }
}

extension Image {
    func data(url:URL) -> Self {
        if let data = try? Data(contentsOf: url) {
            return Image(nsImage: NSImage(data: data)!)
                .resizable()
        }
        return self
            .resizable()
    }
    
}
