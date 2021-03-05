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
                    Button(action: {displayedSubmissionLink = nil}){
                        Text("Approve")
                    }
                    .foregroundColor(.green)
                    Button(action: {displayedSubmissionLink = nil}){
                        Text("Back")
                    }
                    Button(action: {displayedSubmissionLink = nil}){
                        Text("Back")
                    }
                    Spacer()
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
