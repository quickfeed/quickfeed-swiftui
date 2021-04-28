//
//  SubmissionReview.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 03/03/2021.
//

import SwiftUI
import AppKit

struct SubmissionReview: View {
    @ObservedObject var viewModel: TeacherViewModel
    @State var submissionLink: SubmissionLink
    var user: User
    
    var newReview: Review{
        var review = Review()
        let assg = self.viewModel.assignments.first(where: {$0.id == submissionLink.assignment.id})
        review.benchmarks = assg!.gradingBenchmarks
        review.submissionID = submissionLink.submission.id
        review.reviewerID = viewModel.user.id
        review.ready = false
        review.score = 0
        review.feedback = ""
        return review
    }
    
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
                            GradingList(viewModel: viewModel,
                                       review: submissionLink.submission.reviews.first(where: {$0.reviewerID == viewModel.user.id})!,
                                       isCreated: true)
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
                        GradingList(viewModel: viewModel,
                                    review: newReview,
                                    isCreated: false)
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
        .padding()
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

