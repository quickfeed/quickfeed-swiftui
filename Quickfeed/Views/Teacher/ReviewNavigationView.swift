//
//  ReviewNavigatorView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 07/02/2021.
//

import SwiftUI

struct ReviewNavigationView: View {
    @ObservedObject var viewModel: TeacherViewModel
    @State private var searchQuery: String = ""
    @Binding var selectedLab: UInt64
    @State private var showCompleted: Bool = true
    
    
    func selectedSubmissionLink(links: [SubmissionLink]) -> SubmissionLink {
        return links.first(where: {
            $0.assignment.id == self.selectedLab
        }) ?? links[0]
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
    
    var body: some View {
        
        NavigationView{
            VStack(alignment: .leading){
                LabPicker(labs: viewModel.manuallyGradedAssignments, selectedLab: $selectedLab)
                
                SearchFieldRepresentable(query: $searchQuery)
                    .padding(2)
                    .frame(height: 25)
                
                Toggle("Show completed", isOn: $showCompleted)
                
                List{
                    Section(header: SubmissionListHeader()){
                        ForEach(viewModel.enrollmentLinks.filter({ matchesQuery(user: $0.enrollment.user) }), id: \.enrollment.user.id){ link in
                            NavigationLink(destination: SubmissionReview(user: link.enrollment.user, viewModel: viewModel, submissionLink: selectedSubmissionLink(links: link.submissions), selectedLab: $selectedLab)){
                                VStack{
                                    SubmissionListItem(submitterName: link.enrollment.user.name, subLink: selectedSubmissionLink(links: link.submissions))
                                    Divider()
                                }
                            }
                        }
                    }
                }
                .cornerRadius(5)
                
                
            }
            .frame(minWidth: 300)
            .padding()
            
        }
        .onAppear(perform: {
            viewModel.loadEnrollmentLinks()
        })
        
        
        
    }
}

struct ReviewNavigatorView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewNavigationView(viewModel: TeacherViewModel(provider: FakeProvider(), course: Course()), selectedLab: .constant(1))
    }
}
