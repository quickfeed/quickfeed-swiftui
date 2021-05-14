//
//  ReleaseList.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 13/05/2021.
//

import SwiftUI

import SwiftUI
import SwiftUIX


struct ReleaseList: View {
    @ObservedObject var viewModel: TeacherViewModel
    @Binding var selectedLab: UInt64
    @State private var searchQuery: String = ""
    @State private var isShowingSheet = false
    @State var isSearching: Bool = false
    @State private var displayedEnrollmentLink: EnrollmentLink?
    
    var filteredEnrollmentLinks: [EnrollmentLink] {
        return viewModel.enrollmentLinks.filter({
            matchesQuery(user: $0.enrollment.user)
        })
    }
    func setLink(link: EnrollmentLink){
        self.displayedEnrollmentLink = link
    }
    var body: some View {
        List{
            Section(header: ReleaseListHeader()){
                ForEach(filteredEnrollmentLinks, id: \.self) { link in
                    ReleaseListItem(submitterName: link.enrollment.user.name,
                                       subLink: link.submissions.first(where: {$0.assignment.id == selectedLab})!
                    )
                    .environmentObject(viewModel)
                    .contentShape(Rectangle())
                    .onTapGesture(perform: {
                        setLink(link: link)
                        isShowingSheet.toggle()
                    })
                    Divider()
                }
                
            }
            
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
                ReleaseSheet(selectedLab: $selectedLab, enrollmentLink: $displayedEnrollmentLink)
                    .environmentObject(viewModel)
                Spacer()
            }
            .frame(minWidth: 700, minHeight: 700)
            .onKeyboardShortcut(.escape, perform: {
                if isShowingSheet{
                    isShowingSheet.toggle()
                }
            })
        }
        .onAppear(perform: {
            viewModel.loadEnrollmentLinks()
        })
        .navigationTitle("Release Submissions")
        .navigationSubtitle(viewModel.currentCourse.name)
        .toolbar{
            ToolbarItem{
                LabPicker(labs: viewModel.manuallyGradedAssignments, selectedLab: $selectedLab)
            }
            ToolbarItem{
                SearchFieldToolbarItem(isSearching: $isSearching, searchQuery: $searchQuery)
            }
            ToolbarItem{
                SearchToggleToolbarItem(isSearching: $isSearching)
            }
        }
    }
    
    func didDismiss() {
        viewModel.loadEnrollmentLinks()
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

