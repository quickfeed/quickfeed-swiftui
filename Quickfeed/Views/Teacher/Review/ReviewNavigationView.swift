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
    @State private var filterReady: Bool = false
    @State private var filterInProgress: Bool = false
    @State private var filterNone: Bool = false
    @State private var filterApproved: Bool = false
    @State private var filterRevision: Bool = false
    @State private var filterNoReviews: Bool = false
    
    
    var filteredEnrollmentLinks: [EnrollmentLink] {
        return viewModel.enrollmentLinks.filter({
                matchesQuery(user: $0.enrollment.user)
                    && isShown(link: submissionForSelectedLab(links: $0.submissions))
        })
    }
    func isShown(link: SubmissionLink) -> Bool{
        if filterReady{
            for review in link.submission.reviews{
                if review.ready{
                    continue
                }
            }
            return false
        }
        if filterNoReviews{
            if link.submission.reviews.count > 0{
                return false
            }
        }
        
        return true
    }
    
    
    func submissionForSelectedLab(links: [SubmissionLink]) -> SubmissionLink {
        return links.first(where: {
            $0.assignment.id == self.selectedLab
        }) ?? links[0]
    }
    
    
    
    
    func countMissingSubmissions() -> Int{
        var count = 0
        for enrollmentLink in viewModel.enrollmentLinks{
            if !enrollmentLink.submissions.contains(where: {$0.submission.assignmentID == selectedLab}){
                count += 1
            }
        }
        return count
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
                    .frame(height: 25)
                
                
                HStack{
                    Toggle("Ready", isOn: $filterReady)
                    Toggle("In progress", isOn: $filterInProgress)
                    Toggle("No reviews", isOn: $filterNoReviews)
                }
                HStack{
                    Toggle("None", isOn: $filterNone)
                    Toggle("Approved", isOn: $filterApproved)
                    Toggle("Revision", isOn: $filterRevision)
                }
                
                    
                    
              
                List{
                    Section(header: SubmissionListHeader()){
                        ForEach(filteredEnrollmentLinks, id: \.enrollment.user.id){ link in
                            NavigationLink(destination: SubmissionReview(user: link.enrollment.user, viewModel: viewModel, submissionLink: submissionForSelectedLab(links: link.submissions))){
                                VStack{
                                    SubmissionListItem(submitterName: link.enrollment.user.name, subLink: submissionForSelectedLab(links: link.submissions))
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
        
        .navigationTitle("Review Submissions")
        
        .toolbar{
            Text("")
        }
        
        
        
    }
}

struct ReviewNavigatorView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewNavigationView(viewModel: TeacherViewModel(provider: FakeProvider(), course: Course()), selectedLab: .constant(1))
    }
}
