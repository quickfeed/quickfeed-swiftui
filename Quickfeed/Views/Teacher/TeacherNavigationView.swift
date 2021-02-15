//
//  TeacherNavigationView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 03/02/2021.
//

import SwiftUI


struct TeacherNavigationView: View {
    @StateObject var viewModel: TeacherViewModel
    @State var selectedCourse: UInt64
    @State private var users: [User] = []
    
    var body: some View {
        NavigationView{
            VStack{
                CoursePicker(courses: viewModel.courses, selectedCourse: $selectedCourse)
                    .padding(.top)
                    .padding(.horizontal)
                    .onChange(of: selectedCourse, perform: { value in
                        self.users = self.viewModel.getStudentsForCourse(courseId: selectedCourse)
                    })
                
                List{
                    NavigationLink(destination: Text("Results")){
                        Image(systemName: "chart.bar")
                            .frame(width: 20)
                        Text("Results")
                    }
                    NavigationLink(destination: ReviewNavigationView(selectedCourse: $selectedCourse, users: $users, selectedLab: .constant(1)).environmentObject(viewModel)){
                        Image(systemName: "list.dash")
                            .frame(width: 20)
                        Text("Review")
                    }
                    NavigationLink(destination: Text("Release")){
                        Image(systemName: "arrow.up.doc.fill")
                            .frame(width: 20)
                        Text("Release")
                    }
                    NavigationLink(destination: Text("Groups")){
                        Image(systemName: "person.2")
                            .frame(width: 20)
                        Text("Groups")
                    }
                    NavigationLink(destination: Text("Test")){
                        Image(systemName: "person")
                            .frame(width: 20)
                        Text("Members")
                    }
                    
                    Spacer()
                    GithubLinkSection(orgUrl: "https://github.com/dat310-spring21", isTeacher: true)
                }
            }
            .navigationTitle("test")
        }
        .onAppear(perform: {
            self.users = self.viewModel.getStudentsForCourse(courseId: self.selectedCourse)
        })
    }
}


struct TeacherNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        TeacherNavigationView(viewModel: TeacherViewModel(provider: FakeProvider()), selectedCourse: 111)
    }
}
