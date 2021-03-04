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
        
        HStack{
            Button(action: {displayedSubmissionLink = nil}){
                Text("Back")
            }
            Spacer()
        }
        .padding()
        
        ManuallyGraded(submission: displayedSubmissionLink?.submission ?? Submission())
        
    }
}

struct SubmissionResult_Previews: PreviewProvider {
    static var previews: some View {
        SubmissionResult(displayedSubmissionLink: .constant(nil))
    }
}
