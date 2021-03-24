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
    @State var isSearching: Bool = false
    @State var showingStats: Bool = false
    
    var body: some View {
        SwiftUI.Group{
            if showingStats{
                ResultStats(viewModel: viewModel)
            } else{
                List{
                    Section(header: ResultGridListHeader(assignments: self.viewModel.assignments)){
                        ForEach(self.filteredLinks(), id: \.self){ link in
                            ResultListItem(user: link.enrollment.user, submissionLinks: link.submissions, displayedSubmissionLink: $displayedSubmissionLink)
                            Divider()
                        }
                    }
                }
                
            }
        }
        .onAppear(perform: {
        })
        
        .toolbar{
            ToolbarItem(placement: showingStats ? .navigation : .automatic){
                if showingStats{
                    Button(action: {showingStats = false}, label: {
                        Image(systemName: "chevron.backward")
                    })
                } else{
                    Button(action: {showingStats = true}, label: {
                        Image(systemName: "chart.bar.fill")
                    })
                }
                
                
            }
            ToolbarItem{
                if !isSearching{
                    Toggle(isOn: $isSearching, label: {
                        Image(systemName: "magnifyingglass")
                    })
                    .keyboardShortcut("f")
                } else {
                    SearchFieldRepresentable(query: $searchQuery)
                        .frame(minWidth: 200, maxWidth: 350)
                }
            }
        }
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
