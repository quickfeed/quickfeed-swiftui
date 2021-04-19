//
//  ReviewNavigatorView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 07/02/2021.
//

import SwiftUI
import SwiftUIX

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
    
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                List{
                    if filteredEnrollmentLinks.count > 0{
                        if awaitingReviewEnrollments.count > 0{
                            ReviewListSection(viewModel: viewModel, selectedLab: $selectedLab, enrollmentLinks: awaitingReviewEnrollments, heading: "Pending")
                            
                        }
                        if inProgressEnrollments.count > 0{
                            ReviewListSection(viewModel: viewModel, selectedLab: $selectedLab, enrollmentLinks: inProgressEnrollments, heading: "In Progress")
                        }
                        
                        if readyEnrollments.count > 0{
                            ReviewListSection(viewModel: viewModel, selectedLab: $selectedLab, enrollmentLinks: readyEnrollments, heading: "Ready")
                        }
                        
                        if missingSubmissionEnrollments.count > 0{
                            ReviewListSection(viewModel: viewModel, selectedLab: $selectedLab, enrollmentLinks: missingSubmissionEnrollments, heading: "No Submission")
                        }
                    } else{
                        Text("No matches")
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
                    
                    SearchBar("search...", text: $searchQuery, isEditing: $isSearching)
                        .frame(minWidth: 200, maxWidth: 350)
                        
                        
                    //SearchFieldRepresentable(query: $searchQuery)
                    //    .frame(minWidth: 200, maxWidth: 350)
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
    
}

