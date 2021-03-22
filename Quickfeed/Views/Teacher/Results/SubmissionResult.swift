//
//  SubmissionResult.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 23/02/2021.
//

import SwiftUI

struct SubmissionResult: View {
    @Binding var displayedSubmissionLink: SubmissionLink?
    var body: some View {
        
        VStack{
            StudentLab(assignment: displayedSubmissionLink?.assignment ?? Assignment(), submission: displayedSubmissionLink?.submission)
        
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
                Button(action: {displayedSubmissionLink = nil}){
                    Text("Approve")
                        .foregroundColor(getColorForSubmissionStatus(submissionStatus: .approved))
                }
            }
            ToolbarItem{
                Button(action: {displayedSubmissionLink = nil}){
                    Text("Revision")
                        .foregroundColor(getColorForSubmissionStatus(submissionStatus: .revision))
                }
            }
            
            ToolbarItem{
                Button(action: {displayedSubmissionLink = nil}){
                    Text("Reject")
                        .foregroundColor(getColorForSubmissionStatus(submissionStatus: .rejected))
                }
            }
        }
        
    }
}

struct SubmissionResult_Previews: PreviewProvider {
    static var previews: some View {
        SubmissionResult(displayedSubmissionLink: .constant(nil))
    }
}
