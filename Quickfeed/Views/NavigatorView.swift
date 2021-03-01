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
                TeacherNavigationView(viewModel: TeacherViewModel(provider: ServerProvider(), course: viewModel.getCourse(courseId: selectedCourse)))
                
                Spacer()
                NavigationLink(
                    destination: Text("UserProfile_HardCoded")){
                    Image(systemName: "person.fill")
                    Text("Bjørn Kristian Teisrud")
                }
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
