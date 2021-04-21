//
//  StudentNavigatorView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 25/01/2021.
//

import SwiftUI

struct StudentNavigatorView: View {
    @ObservedObject var viewModel: StudentViewModel
    //@State var reload: Bool = false
    
    init(viewModel: StudentViewModel, course: Course) {
        viewModel.setCourse(course: course)
        self.viewModel = viewModel
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
            GithubLinkSection(orgPath: viewModel.course!.organizationPath, userLogin: viewModel.user.login, group: viewModel.group, isTeacher: false)
                .padding(.leading)
        }
    }
}

/*struct StudentNavigatorView_Previews: PreviewProvider {
 static var previews: some View {
 StudentNavigatorView(viewModel: StudentViewModel(provider: <#T##ProviderProtocol#>, course: <#T##Course#>))
 }
 }*/
