//
//  TeacherNavigationView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 03/02/2021.
//

import SwiftUI


struct TeacherNavigationView: View {
    @ObservedObject var viewModel: TeacherViewModel
    @State private var selectedLabForManualGrading: UInt64 = 0
    
    var body: some View {
        List{
            NavigationLink(destination: ResultView(viewModel: viewModel)){
                Image(systemName: "chart.bar")
                    .frame(width: 20)
                    .foregroundColor(.blue)
                Text("Results")
            }
            
            NavigationLink(destination: MembersView(viewModel: viewModel)){
                Image(systemName: "person")
                    .frame(width: 20)
                    .foregroundColor(.blue)
                Text("Members")
            }
            
            NavigationLink(destination: GroupsView(viewModel: viewModel)){
                Image(systemName: "person.2")
                    .frame(width: 20)
                    .foregroundColor(.blue)
                Text("Groups")
            }
            
            
            if viewModel.manuallyGradedAssignments.count > 0{
                Section(header:Text("Manual Grading")){
                    NavigationLink(destination: ReviewNavigationView(viewModel: viewModel, selectedLab: $selectedLabForManualGrading)){
                        Image(systemName: "list.dash")
                            .frame(width: 20)
                            .foregroundColor(.blue)
                        Text("Review")
                    }
                    NavigationLink(destination: ReleaseNavigationView(viewModel: viewModel, selectedLab: $selectedLabForManualGrading)){
                        Image(systemName: "arrow.up.doc.fill")
                            .frame(width: 20)
                            .foregroundColor(.blue)
                        Text("Release")
                    }
                    
                }
                .onAppear(perform: {
                    self.selectedLabForManualGrading = self.viewModel.manuallyGradedAssignments[0].id
                })
            }
            
            GithubLinkSection(orgPath: viewModel.currentCourse.organizationPath, userLogin: viewModel.user.login, isTeacher: true)
                
        }
        .onAppear(perform: {
            self.viewModel.loadUsers()

            
            
            
            
        })
    }
}


struct TeacherNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        TeacherNavigationView(viewModel: TeacherViewModel(provider: FakeProvider(), course: Course()))
    }
}
