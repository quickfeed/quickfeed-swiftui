//
//  TeacherNavigationView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 03/02/2021.
//

import SwiftUI


struct TeacherNavigationView: View {
    @ObservedObject var viewModel: TeacherViewModel
    @State private var users: [User] = []
    @State private var selectedLabForManualGrading: UInt64 = 0
    
    var body: some View {
        VStack{
            List{
                NavigationLink(destination: ResultView(viewModel: viewModel)){
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
                NavigationLink(destination: MembersView(viewModel: viewModel)){
                    Image(systemName: "person")
                        .frame(width: 20)
                        .foregroundColor(.blue)
                    Text("Members")
                }
                
                
                if viewModel.manuallyGradedAssignments.count > 0{
                    Section(header:Text("Manual Grading")){
                        NavigationLink(destination: ReviewNavigationView(viewModel: viewModel, enrolledUsers: $users, selectedLab: $selectedLabForManualGrading)){
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
                GithubLinkSection(orgUrl: "https://github.com/dat310-spring21", userLogin: viewModel.user.login, isTeacher: true)
            }
            
            
            
        }
        .onAppear(perform: {
            self.viewModel.loadUsers()
            self.viewModel.loadAssignments()
            
            self.selectedLabForManualGrading = self.viewModel.manuallyGradedAssignments[0].id
            
        })
    }
}


struct TeacherNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        TeacherNavigationView(viewModel: TeacherViewModel(provider: FakeProvider(), course: Course()))
    }
}
