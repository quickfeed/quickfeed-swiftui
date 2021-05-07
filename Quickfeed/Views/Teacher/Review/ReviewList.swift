//
//  ReviewList.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 07/02/2021.
//

import SwiftUI
import SwiftUIX


struct ReviewList: View {
    @ObservedObject var viewModel: TeacherViewModel
    @Binding var selectedLab: UInt64
    @State private var searchQuery: String = ""
    @State private var isShowingSheet = false
    @State var isSearching: Bool = false
    @State private var displayedEnrollmentLink: EnrollmentLink?
    @State private var selection: EnrollmentLink?
    var filteredEnrollmentLinks: [EnrollmentLink] {
        return viewModel.enrollmentLinks.filter({
            matchesQuery(user: $0.enrollment.user)
        })
    }
    
    var body: some View {
        List(selection: $selection){
            Section(header: ReviewListHeader()){
                ForEach(filteredEnrollmentLinks, id: \.self) { link in
                    SubmissionListItem(submitterName: link.enrollment.user.name,
                                       subLink: link.submissions.first(where: {$0.assignment.id == selectedLab})!,
                                       reviewer: "test")
                        .contentShape(Rectangle())
                        .onTapGesture(perform: {
                            displayedEnrollmentLink = link
                            assert(displayedEnrollmentLink != nil)
                            isShowingSheet.toggle()
                        })
                    Divider()
                }
                .sheet(isPresented: $isShowingSheet,
                       onDismiss: didDismiss) {
                    VStack {
                        HStack{
                            Spacer()
                            Button(action: {isShowingSheet.toggle()}, label: {
                                Image(systemName: "multiply")
                                    .font(.title)
                            })
                            .padding()
                            .help("esc")
                            .buttonStyle(PlainButtonStyle())
                        }
                        if displayedEnrollmentLink == nil{
                            Text("DEBUG: Enrollment not found")
                        } else {
                            SubmissionReview(viewModel: viewModel,
                                             submissionLink: displayedEnrollmentLink!.submissions.first(where: {$0.assignment.id == selectedLab})!,
                                             user: displayedEnrollmentLink!.enrollment.user)
                        }
                    }
                    .frame(minWidth: 700, minHeight: 700)
                    .onKeyboardShortcut(.escape, perform: {
                        if isShowingSheet{
                            isShowingSheet.toggle()
                        }
                    })
                }
            }
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
                }
            }
            ToolbarItem{
                if isSearching{
                    Button(action: {
                        isSearching = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            isSearching = true
                        }
                    }, label: {
                    })
                    .keyboardShortcut("f")
                    .labelsHidden()
                }
            }
        }
    }
    
    func didDismiss() {
        // Handle the dismissing action.
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

