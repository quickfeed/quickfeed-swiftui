//
//  ResultGrid.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 23/02/2021.
//

import SwiftUI

struct ResultGrid: View {
    @ObservedObject var viewModel: TeacherViewModel
    @Binding var displayedSubmissionLink: SubmissionLink?
    @State var searchQuery: String = ""
    
    var body: some View {
        VStack{
            Text("Results for \(viewModel.currentCourse.name)")
            SearchFieldRepresentable(query: $searchQuery)
                .padding(.horizontal)
                .frame(height: 20)
            List{
                Section(header: ResultGridListHeader(assignments: self.viewModel.assignments)){
                    ForEach(self.filteredLinks(), id: \.self){ link in
                        ResultListItem(user: link.enrollment.user, submissionLinks: link.submissions, displayedSubmissionLink: $displayedSubmissionLink)
                        Divider()
                    }
                }
                
            }
            .padding(.top, 0)
        }
        .onAppear(perform: {
        })
    }
    
    func filteredLinks() -> [EnrollmentLink] {
        return viewModel.enrollmentLinks.filter({ matchesQuery(user: $0.enrollment.user) })
    }
    
    func matchesQuery(user: User) -> Bool{
        if searchQuery == ""{
            return true
        }
        
        if  user.name.lowercased().contains(self.searchQuery.lowercased()){
            return true
        }
        
        if  user.email.lowercased().contains(self.searchQuery.lowercased()){
            return true
        }
        
        if user.studentID.lowercased().contains(self.searchQuery.lowercased()){
            return true
        }
        
        if user.login.lowercased().contains(self.searchQuery.lowercased()){
            return true
        }
        
        
        return false
    }
}

struct ResultGrid_Previews: PreviewProvider {
    static var previews: some View {
        ResultGrid(viewModel: TeacherViewModel(provider: FakeProvider(), course: Course()), displayedSubmissionLink: .constant(nil))
    }
}
