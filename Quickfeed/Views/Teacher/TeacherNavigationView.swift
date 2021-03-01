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
    @State private var selectedLabForManualGrading: UInt64 = 0
    
    var body: some View {
        NavigationView{
            VStack{
                CoursePicker(courses: viewModel.courses, selectedCourse: $selectedCourse)
                    .padding(.top)
                    .padding(.horizontal)
                    .onChange(of: selectedCourse, perform: { value in
                        self.users = self.viewModel.getStudentsForCourse(courseId: selectedCourse)
                        print("test")
                    })
                
                List{
                    NavigationLink(destination: ResultView(selectedCourse: .constant(111))
                                    .environmentObject(ResultViewModel(courseId: selectedCourse))){
                        Image(systemName: "chart.bar")
                            .frame(width: 20)
                            .foregroundColor(.blue)
                        Text("Results")
                    }
                    
                    NavigationLink(destination: Text("Groups")){
                        Image(systemName: "person.2")
                            .frame(width: 20)
                            .foregroundColor(.blue)
                        Text("Groups")
                    }
                    NavigationLink(destination: MembersView(course: self.viewModel.getCourse(courseId: selectedCourse)).environmentObject(viewModel)){
                        Image(systemName: "person")
                            .frame(width: 20)
                            .foregroundColor(.blue)
                        Text("Members")
                    }
                    
                    
                    if viewModel.getManuallyGradedAssignments(courseId: selectedCourse).count > 0{
                        Section(header:Text("Manual Grading")){
                            NavigationLink(destination: ReviewNavigationView(selectedCourse: $selectedCourse,enrolledUsers: $users, selectedLab: $selectedLabForManualGrading).environmentObject(viewModel)){
                                Image(systemName: "list.dash")
                                    .frame(width: 20)
                                    .foregroundColor(.blue)
                                Text("Review")
                            }
                            NavigationLink(destination: Text("Release")){
                                Image(systemName: "arrow.up.doc.fill")
                                    .frame(width: 20)
                                    .foregroundColor(.blue)
                                Text("Release")
                            }
                            
                        }
                    }
                    
                    
                    Spacer()
                    GithubLinkSection(orgPath: "dat310-spring21", userLogin: viewModel.user.login, isTeacher: true)
                }
            }
            
            
        }
        .onAppear(perform: {
            self.users = self.viewModel.getStudentsForCourse(courseId: self.selectedCourse)
            self.selectedLabForManualGrading = self.viewModel.getManuallyGradedAssignments(courseId: selectedCourse)[0].id
        })
    }
}


struct TeacherNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        TeacherNavigationView(viewModel: TeacherViewModel(provider: FakeProvider()), selectedCourse: 111)
    }
}
