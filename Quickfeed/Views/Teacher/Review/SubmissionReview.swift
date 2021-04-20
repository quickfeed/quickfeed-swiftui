//
//  SubmissionReview.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 03/03/2021.
//

import SwiftUI
import AppKit


struct SubmissionReview: View {
    var user: User
    @ObservedObject var viewModel: TeacherViewModel
    @State var submissionLink: SubmissionLink
    @State private var review: Review = Review()
    
    
    //Initializes a new review
    func initReview(){
        if submissionLink.submission.reviews.count < submissionLink.assignment.reviewers{
            self.review = viewModel.createReview(submissionId: self.submissionLink.submission.id, assignmentId: submissionLink.assignment.id)!
        } else{
            print("Maximum numbers of reviewers reached")
        }
        
    }
    
    func updateReview(){
        print("update review")
        
    }
    
    func assignmentHasCriteriaList() -> Bool{
        let assg = viewModel.assignments.first(where: {$0.id == submissionLink.assignment.id})
        if assg!.gradingBenchmarks.count > 0{
            return true
        }
        return false
    }
    
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
            SubmissionRepoLink(submissionLink: submissionLink, orgPath: viewModel.currentCourse.organizationPath, user: user)
            SubmissionInfo(viewModel: viewModel, submissionLink: $submissionLink)
                .onAppear(perform: {
                    if !hasReview(){
                        initReview()
                    }
                })
            if submissionLink.hasSubmission{
                if assignmentHasCriteriaList(){
                    if hasReview(){
                        if hasReviewByUser(){
                            List {
                                ForEach(self.review.benchmarks.indices, id: \.self){ idx in
                                    Text("test")
                                    GradingBenchmarkSection(benchmark: $review.benchmarks[idx])
                                }
                                .onChange(of: review, perform: { value in
                                    updateReview()
                                })
                            }
                            .onAppear(perform: {
                                self.review = submissionLink.submission.reviews.first(where: {$0.reviewerID == viewModel.user.id})!
                            })
                        } else{
                            HStack{
                                Text("This assignment is reviewed by: ")
                                ForEach(submissionLink.submission.reviews, id: \.self){ review in
                                    Text("\(viewModel.getUserName(userId: review.reviewerID))")
                                }
                            }
                        }
                    }
                }
                else{
                    Text("No criteria list for this assignment")
                }
            } else {
                Text("No submissions for this assignment")
            }
            Spacer()
        }
        .padding()
    }
}

