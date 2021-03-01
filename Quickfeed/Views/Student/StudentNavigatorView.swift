//
//  StudentNavigatorView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 25/01/2021.
//

import SwiftUI

struct StudentNavigatorView: View {
    @ObservedObject var viewModel: StudentViewModel
    
    var body: some View {
        List{
            LabSection(assignments: viewModel.getAssignments(courseID: viewModel.course.id))
            GithubLinkSection(orgPath: viewModel.course.organizationPath, userLogin: viewModel.user.login, isTeacher: false)
        }
    }
}

/*struct StudentNavigatorView_Previews: PreviewProvider {
 static var previews: some View {
 StudentNavigatorView(viewModel: StudentViewModel(provider: <#T##ProviderProtocol#>, course: <#T##Course#>))
 }
 }*/
