//
//  StudentNavigatorView.swift
//  Quickfeed
//

import SwiftUI

struct StudentNavigatorView: View {
    @ObservedObject var viewModel: StudentViewModel = StudentViewModel.shared
    
    init(viewModelTest: StudentViewModel, course: Course) {
        viewModel.setCourse(course: course)
        viewModel.getAssignments()
        viewModel.getSubmissions()
    }
    
    var body: some View {
        HStack{
            if viewModel.course!.slipDays != 0 {
                Text("Remaining SlipDays: \(viewModel.getSlipdays()!)")
                    .padding(.leading)
            } else {
                Text("No SlipDays for this course")
                    .padding(.leading)
            }
            Spacer()
            Image(systemName: "arrow.clockwise")
                .padding(.trailing)
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.reload()
                }
        }
        List{
            LabSection(viewModel: viewModel)
            if viewModel.group == nil && viewModel.hasGroupAssignments(){
                Section(header: Text("Groups")){
                    NavigationLink(destination: NewGroup(viewModel: viewModel)){
                        HStack{
                            Text("New Group")
                            Spacer()
                            Image(systemName: "person.3.fill")
                        }
                        .padding(.leading)
                    }
                }
            }
            GithubLinkSection(orgPath: viewModel.course!.organizationPath, userLogin: viewModel.user.login, group: viewModel.group, isTeacher: false)
                .padding(.leading)
        }
    }
}
