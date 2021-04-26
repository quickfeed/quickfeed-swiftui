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
    
    
    
    var body: some View {
        VStack{
            Text("\(user.name)'s submission for \(submissionLink.assignment.name)")
                .font(.title)
                .fontWeight(.bold)
            SubmissionRepoLink(assignmentName: submissionLink.assignment.name, orgPath: viewModel.currentCourse.organizationPath, userLogin: user.login)
            SubmissionInfo(viewModel: viewModel, submissionLink: $submissionLink)
            if submissionLink.hasSubmission{
                if assignmentHasCriteriaList(){
                    if hasReview(){
                        if hasReviewByUser(){
                            List {
                                ForEach(self.review.benchmarks.indices, id: \.self){ idx in
                                    GradingBenchmarkSection(viewModel: viewModel, benchmark: $review.benchmarks[idx], review: $review)
                                }
                            }
                            .onAppear(perform: {
                                self.review = submissionLink.submission.reviews.first(where: {$0.reviewerID == viewModel.user.id})!
                            })
                            HStack{
                                Spacer()
                                Button(action: {
                                    self.review.ready = true
                                    viewModel.updateReview(review: review)
                                    viewModel.loadEnrollmentLinks()
                                }, label: {
                                    Text("Mark as Ready")
                                })
                            }
                            
                        } else{
                            HStack{
                                Text("This assignment is reviewed by: ")
                                ForEach(submissionLink.submission.reviews, id: \.self){ review in
                                    Text("\(viewModel.getUserName(userId: review.reviewerID))")
                                }
                            }
                        }
                    }
                    else{
                        Text("No reviews")
                    }
                }
                else{
                    Text("Criteria list is not available for this assignment")
                }
            } else {
                Text("No submissions for this assignment")
            }
            Spacer()
        }
        .onAppear(perform: {
            if !hasReview(){
                initReview()
            }
        })
        .padding()
    }
    
    
    //Initializes a new review
    func initReview(){
        if !submissionLink.hasSubmission{
            return
        }
        if submissionLink.submission.reviews.count < submissionLink.assignment.reviewers{
            self.review = viewModel.createReview(submissionId: self.submissionLink.submission.id, assignmentId: submissionLink.assignment.id)!
        } else{
            print("Maximum numbers of reviewers reached")
        }
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
}

