//
//  SubmissionInfo.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 03/03/2021.
//

import SwiftUI

struct SubmissionInfo: View {
    @ObservedObject var viewModel: TeacherViewModel
    @Binding var submissionLink: SubmissionLink
    
    
    var body: some View {
        VStack{
            HStack{
                Text("Score:")
                Spacer()
                Text("\(submissionLink.submission.score)%")
            }
            Divider()
            HStack{
                Text("Reviews:")
                Spacer()
                Text("\(submissionLink.submission.reviews.count) / \(submissionLink.assignment.reviewers)")
            }
            Divider()
            HStack {
                Text("Review Status:")
                Spacer()
                if !hasReview(){
                    Text("None")
                }
                else if hasReviewInProgress(){
                    Text("In Progress")
                }
                else{
                    Text("Ready")
                }
            
            }
            Divider()
            HStack{
                Text("Submission Status:")
                Spacer()
                Text(translateSubmissionStatus(statusCode: submissionLink.submission.status))
            }
            Divider()
            
            
            
        }
    }
    
    func hasReview() -> Bool{
        if submissionLink.submission.reviews.count == 0{
            return false
        }
        return true
    }
    
    func hasReviewInProgress() -> Bool{
        if submissionLink.submission.reviews.count > 0 && submissionLink.submission.reviews.allSatisfy({!$0.ready}){
           return true
        }
    
        return false
        
    }
    
}

struct SubmissionInfo_Previews: PreviewProvider {
    static var previews: some View {
        SubmissionInfo(viewModel: TeacherViewModel(provider: FakeProvider(), course: Course()), submissionLink: .constant(SubmissionLink()))
    }
}
