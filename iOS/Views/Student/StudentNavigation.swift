//
//  StudentNavigation.swift
//  QuickFeed (iOS)
//
//  Created by Bjørn Kristian Teisrud on 02/08/2021.
//

import SwiftUI

struct StudentNavigation: View {
    @ObservedObject var viewModel: StudentViewModel
    
    var body: some View {
        if viewModel.group == nil && viewModel.hasGroupAssignments(){
            Section(header: Text("Group")){
                NavigationLink(
                    destination: Text("New Group")){
                    HStack{
                        Text("New Group")
                        Spacer()
                        Image(systemName: "person.3.fill")
                    }
                }
            }
        }
        LabSection(viewModel: viewModel)
        GitHubRepos(viewModel: viewModel)
    }
}

struct LabSection: View {
    @ObservedObject var viewModel: StudentViewModel
    
    var body: some View {
        Section(header: Text("Labs")){
            if viewModel.assignments == [] {
                Text("No assignments for this course yet.")
            } else {
                ForEach(viewModel.assignments, id: \.id){ assignment in
                    NavigationLink(
                        destination: Text(assignment.name)){
                        HStack{
                            if viewModel.getSubmission(assignment: assignment) != nil {
                                getImageForSubmissionStatus(submission: viewModel.getSubmission(assignment: assignment)!.status)
                                    .padding(.trailing)
                                    .frame(width: 5)
                                    .foregroundColor(getColorForSubmissionStatus(submissionStatus: viewModel.getSubmission(assignment: assignment)!.status))
                            }
                            Text(assignment.name)
                            if assignment.isGroupLab{
                                Spacer()
                                Image(systemName: "person.3.fill")
                            }
                        }
                    }
                }
                .padding(.leading)
            }
        }
    }
}

struct GitHubRepos: View {
    @ObservedObject var viewModel: StudentViewModel
    
    var body: some View {
        Section(header: Text("Repositories")){
            Link("\(viewModel.user.login)-labs", destination: URL(string: "https://github.com/" + viewModel.course.organizationPath + "/" + viewModel.user.login + "-labs")!)
            if viewModel.group != nil {
                Link("\(viewModel.group!.name)", destination: URL(string: "https://github.com/" + viewModel.course.organizationPath + "/" + viewModel.group!.name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)!)
            }
            Link("course-info", destination: URL(string: "https://github.com/" + viewModel.course.organizationPath + "/course-info")!)
            Link("assignments", destination: URL(string: "https://github.com/" + viewModel.course.organizationPath + "/assignments")!)
        }
    }
}
