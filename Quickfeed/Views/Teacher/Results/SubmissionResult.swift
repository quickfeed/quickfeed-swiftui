//
//  SubmissionResult.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 23/02/2021.
//

import SwiftUI

struct SubmissionResult: View {
    @ObservedObject var viewModel: TeacherViewModel
    @Binding var displayedSubmissionLink: SubmissionLink?
    var body: some View {
        
        VStack{
            if displayedSubmissionLink != nil{
                StudentLab(assignment: displayedSubmissionLink!.assignment, submission: displayedSubmissionLink!.submission)
            }
            
        }
        .padding()
        .navigationTitle("\(displayedSubmissionLink?.assignment.name ?? "")")
        .toolbar{
            ToolbarItem(placement: ToolbarItemPlacement.navigation){
                Button(action: {displayedSubmissionLink = nil}){
                    Image(systemName: "chevron.backward")
                }
            }
            ToolbarItem{
                Button(action: {
                    displayedSubmissionLink?.submission.status = .approved
                    _ = viewModel.updateSubmission(submission: displayedSubmissionLink!.submission)
                }){
                    Text("Approve")
                        .foregroundColor(getColorForSubmissionStatus(submissionStatus: .approved))
                }
            }
            ToolbarItem{
                Button(action: {
                    displayedSubmissionLink?.submission.status = .revision
                    _ = viewModel.updateSubmission(submission: displayedSubmissionLink!.submission)
                }){
                    Text("Revision")
                        .foregroundColor(getColorForSubmissionStatus(submissionStatus: .revision))
                }
            }
            
            ToolbarItem{
                Button(action: {
                    displayedSubmissionLink?.submission.status = .rejected
                    _ = viewModel.updateSubmission(submission: displayedSubmissionLink!.submission)
                }){
                    Text("Reject")
                        .foregroundColor(getColorForSubmissionStatus(submissionStatus: .rejected))
                }
            }
        }
        
    }
}

