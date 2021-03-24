//
//  ReviewNavigatorView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 07/02/2021.
//

import SwiftUI


// Overides translusent background for the list

extension NSTableView {
  open override func viewDidMoveToWindow() {
    super.viewDidMoveToWindow()

    backgroundColor = NSColor.clear
    if enclosingScrollView != nil {
        enclosingScrollView!.drawsBackground = false
    }
    
  }

}





struct ReviewNavigationView: View {
    @ObservedObject var viewModel: TeacherViewModel
    @State private var searchQuery: String = ""
    @Binding var selectedLab: UInt64
    @State var isSearching: Bool = false
   
    var filteredEnrollmentLinks: [EnrollmentLink] {
        return viewModel.enrollmentLinks.filter({
                matchesQuery(user: $0.enrollment.user)
        })
    }
    
    var awaitingReviewEnrollments: [EnrollmentLink] {
        return filteredEnrollmentLinks.filter{
            hasSubmissionForSelectedLab(link: $0) &&
            !hasReview(link: $0)
        }
    }
    
    var inProgressEnrollments: [EnrollmentLink]{
        return filteredEnrollmentLinks.filter({
            hasSubmissionForSelectedLab(link: $0) &&
            hasNonReadyReview(link: $0)
        })
    }
    
    var readyEnrollments: [EnrollmentLink]{
        return filteredEnrollmentLinks.filter({
            hasReadyReviewForAssignment(link: $0)
        })
    }
    
    var missingSubmissionEnrollments: [EnrollmentLink]{
        return filteredEnrollmentLinks.filter({
            !hasSubmissionForSelectedLab(link: $0)
        })
    }
    
    func hasReview(link: EnrollmentLink) -> Bool{
        let subForLab = submissionForSelectedLab(links: link.submissions)
        if subForLab != nil{
            if subForLab!.submission.reviews.count > 0{
               return true
            }
        }
        return false
    }
    
    func hasNonReadyReview(link: EnrollmentLink) -> Bool{
        let subForLab = submissionForSelectedLab(links: link.submissions)
        if subForLab != nil{
            if subForLab!.submission.reviews.count > 0 && subForLab!.submission.reviews.allSatisfy({!$0.ready}){
               return true
            }
        }
        return false
        
    }
    
   
    
    func hasSubmissionForSelectedLab(link: EnrollmentLink) -> Bool{
        let subForLab = link.submissions.first(where: { $0.assignment.id == selectedLab } )
        if subForLab != nil{
            if subForLab!.hasSubmission{
                return true
            }
            
        }
        
        return false
    }
    
    func submissionForSelectedLab(links: [SubmissionLink]) -> SubmissionLink? {
        return links.first(where: {
            $0.assignment.id == self.selectedLab
        })
    }
    
    
    
    func hasReadyReviewForAssignment(link: EnrollmentLink) -> Bool{
        let subForLab = submissionForSelectedLab(links: link.submissions)
        if subForLab != nil{
            if subForLab!.submission.reviews.contains(where: {$0.ready}){
               return true
            }
        }
        return false
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
                
                
                List{
                    if awaitingReviewEnrollments.count > 0{
                        Section(header: Text("To Do (\(awaitingReviewEnrollments.count))")){
                            ForEach(awaitingReviewEnrollments, id: \.self){ link in
                                NavigationLink(destination: SubmissionReview(user: link.enrollment.user, viewModel: viewModel, submissionLink: submissionForSelectedLab(links: link.submissions)!)){
                                    VStack{
                                        SubmissionListItem(submitterName: link.enrollment.user.name, subLink: submissionForSelectedLab(links: link.submissions)!)
                                        Divider()
                                    }
                                }
                            }
                        }
                    }
                    
                   
                    
                    if inProgressEnrollments.count > 0{
                        Section(header: Text("In Progress (\(inProgressEnrollments.count))")){
                            ForEach(inProgressEnrollments, id: \.self){ link in
                                NavigationLink(destination: SubmissionReview(user: link.enrollment.user, viewModel: viewModel, submissionLink: submissionForSelectedLab(links: link.submissions)!)){
                                    VStack{
                                        SubmissionListItem(submitterName: link.enrollment.user.name, subLink: submissionForSelectedLab(links: link.submissions)!)
                                        Divider()
                                    }
                                }
                            }
                        }
                    }
                    
                    if readyEnrollments.count > 0{
                        Section(header: Text("Ready (\(readyEnrollments.count))")){
                            ForEach(readyEnrollments, id: \.self){ link in
                                NavigationLink(destination: SubmissionReview(user: link.enrollment.user, viewModel: viewModel, submissionLink: submissionForSelectedLab(links: link.submissions)!)){
                                    VStack{
                                        SubmissionListItem(submitterName: link.enrollment.user.name, subLink: submissionForSelectedLab(links: link.submissions)!)
                                        Divider()
                                    }
                                }
                            }
                        }
                        
                    }
                    
                    if missingSubmissionEnrollments.count > 0{
                        Section(header: Text("No submissions (\(missingSubmissionEnrollments.count))")){
                            ForEach(missingSubmissionEnrollments, id: \.self){ link in
                                NavigationLink(destination: SubmissionReview(user: link.enrollment.user, viewModel: viewModel, submissionLink: submissionForSelectedLab(links: link.submissions)!)){
                                    VStack{
                                        SubmissionListItem(submitterName: link.enrollment.user.name, subLink: submissionForSelectedLab(links: link.submissions)!)
                                        Divider()
                                    }
                                }
                            }
                        }
                        
                    }
                }
                
                .cornerRadius(5)
                .listStyle(SidebarListStyle())
                .background(Color.clear)
                

            }
            .padding(.top)
            .frame(minWidth: 300)
            
        }
        .onAppear(perform: {
            viewModel.loadEnrollmentLinks()
        })
        
        .navigationTitle("Review Submissions")
        .navigationSubtitle(viewModel.currentCourse.name)

        .toolbar{
            ToolbarItem{
            LabPicker(labs: viewModel.manuallyGradedAssignments, selectedLab: $selectedLab)
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
                        .onExitCommand(perform: {self.isSearching = false})
                }
            }
            ToolbarItem{
                if isSearching{
                    Toggle(isOn: $isSearching, label: {
                        Image(systemName: "magnifyingglass")
                    })
                    .keyboardShortcut("f")
                    .labelsHidden()
                }
            }
        }
        
        
        
        
    }
}

struct ReviewNavigatorView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewNavigationView(viewModel: TeacherViewModel(provider: FakeProvider(), course: Course()), selectedLab: .constant(1))
    }
}
