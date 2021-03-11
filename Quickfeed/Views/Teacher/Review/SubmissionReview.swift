//
//  SubmissionReview.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 03/03/2021.
//

import SwiftUI

struct SubmissionReview: View {
    var user: User
    @ObservedObject var viewModel: TeacherViewModel
    @State var submissionLink: SubmissionLink
    
    @State private var review: Review = Review()
    
    
    func hasReview() -> Bool{
        if submissionLink.submission.reviews.count > 0{
            return true
        }
        return false
    }
    
    func hasReviewByUser() -> Bool{
        if submissionLink.submission.reviews.count > 0{
            for review in submissionLink.submission.reviews{
                if review.reviewerID == viewModel.user.id{
                    return true
                }
            }
        }
        return false
    }
    
    var body: some View {
        VStack{
            Text("\(user.name)'s submission for \(submissionLink.assignment.name)")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom)
            SubmissionInfo(viewModel: viewModel, submissionLink: $submissionLink)
            if submissionLink.hasSubmission{
                if hasReviewByUser(){
                    List{
                        ForEach(self.review.benchmarks.indices, id: \.self){ idx in
                            GradingBenchmarkSection(benchmark: $review.benchmarks[idx])
                        }
                    }
                    .onAppear(perform:{
                        self.review = submissionLink.submission.reviews.first ?? viewModel.createReview() ?? Review()
                    })
                    .cornerRadius(5)
                    
                    HStack{
                        Spacer()
                        Button(action: { }, label: {
                            Text("Mark as ready")
                        })
                    }
                    
                } else {
                    if hasReview(){
                        HStack{
                            Text("This assignment is reviewed by: ")
                            ForEach(submissionLink.submission.reviews, id: \.self){ review in
                                Text("\(viewModel.getUserName(userId: review.reviewerID))")
                            }
                            if submissionLink.submission.released{
                                Text("Released")
                            }
                        }
                        
                    }
                
                }
                
                
                
            } else{
                Text("No submissions for this assignment")
            }
            Spacer()
           
            
            
            
        }
        .padding()
        
    }
}

struct SubmissionReview_Previews: PreviewProvider {
    static var previews: some View {
        SubmissionReview(user: User(), viewModel: TeacherViewModel(provider: FakeProvider(), course: Course()), submissionLink: SubmissionLink())
    }
}
