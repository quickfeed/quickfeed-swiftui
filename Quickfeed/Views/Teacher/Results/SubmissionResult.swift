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
        
        ZStack{
            StudentLab(assignment: displayedSubmissionLink?.assignment ?? Assignment(), submission: displayedSubmissionLink?.submission)
            VStack{
                HStack{
                    Button(action: {displayedSubmissionLink = nil}){
                        Text("Back")
                    }
                    Spacer()
                    Button(action: {displayedSubmissionLink = nil}){
                        Text("Approve")
                            .foregroundColor(getColorForSubmissionStatus(submissionStatus: .approved))
                    }
                    Button(action: {displayedSubmissionLink = nil}){
                        Text("Revision")
                            .foregroundColor(getColorForSubmissionStatus(submissionStatus: .revision))
                    }
                    Button(action: {displayedSubmissionLink = nil}){
                        Text("Reject")
                            .foregroundColor(getColorForSubmissionStatus(submissionStatus: .rejected))
                    }
                }
                Spacer()
            }
            //Spacer()
        }
        .padding()
        
        //StudentLab(assignment: displayedSubmissionLink?.assignment ?? Assignment(), submission: displayedSubmissionLink?.submission)
        
    }
}

struct SubmissionResult_Previews: PreviewProvider {
    static var previews: some View {
        SubmissionResult(displayedSubmissionLink: .constant(nil))
    }
}
