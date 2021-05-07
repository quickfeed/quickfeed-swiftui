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
    @State private var activeDest: Int? = 1
    
    var body: some View {
        List{
            NavigationLink(destination: ResultView(viewModel: viewModel), tag: 1, selection: $activeDest){
                Image(systemName: "chart.bar")
                    .frame(width: 20)
                    .foregroundColor(.blue)
                Text("Results")
            }
            
            NavigationLink(destination: MembersView(viewModel: viewModel), tag: 2, selection: $activeDest){
                Image(systemName: "person")
                    .frame(width: 20)
                    .foregroundColor(.blue)
                Text("Members")
            }
            
            NavigationLink(destination: GroupsView(viewModel: viewModel), tag: 3, selection: $activeDest){
                Image(systemName: "person.2")
                    .frame(width: 20)
                    .foregroundColor(.blue)
                Text("Groups")
            }
            
            NavigationLink(destination: AssignmentsView(viewModel: viewModel), tag: 4, selection: $activeDest){
                Image(systemName: "doc")
                    .frame(width: 20)
                    .foregroundColor(.blue)
                Text("Assignments")
            }
            
            
            if viewModel.manuallyGradedAssignments.count > 0{
                Section(header:Text("Manual Grading")){
                    NavigationLink(destination: ReviewList(viewModel: viewModel, selectedLab: $selectedLabForManualGrading)){
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
