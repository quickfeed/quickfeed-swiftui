//
//  ReleaseListItem.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 13/05/2021.
//

import SwiftUI

struct ReleaseListItem: View {
    @EnvironmentObject var viewModel: TeacherViewModel
    var submitterName: String
    var subLink: SubmissionLink
    
    var reviews: Int {
        return subLink.submission.reviews.count
    }
    
    var reviewers: [String]{
        var reviewers = [String]()
        if reviews > 0{
            for review in subLink.submission.reviews{
                reviewers.append(viewModel.getUserName(userId: review.reviewerID))
            }
        }
        return reviewers
    }
    
    var body: some View {
        HStack{
            Text(submitterName)
                .frame(width: 200, alignment: .leading)
            Spacer()
            Text("\(reviews)/\(subLink.assignment.reviewers)")
                .frame(width: 200, alignment: .leading)
            Spacer()
            VStack(alignment: .leading){
                if reviewers.count > 0{
                    ForEach(reviewers.indices, id: \.self) { i in
                        Text(reviewers[i])
                            .frame(width: 190, alignment: .leading)
                    }
                } else{
                    Text("N/A")
                }
            }
            .frame(width: 200, alignment: .leading)
            Spacer()
            Image(systemName: getImageSysNameForSubmissionStatus(status: subLink.submission.status))
                .foregroundColor(getColorForSubmissionStatus(submissionStatus: subLink.submission.status))
                .frame(width: 50, alignment: .leading)
            Spacer()
            HStack{
                Button(action: {}, label: {
                    Text(releaseButtonText())
                })
                .disabled(releasable() ? false : true)
                .help("NOT IMPLEMENTED")
            }
            .frame(width: 100, alignment: .trailing)
        }
    }
    
    func releaseButtonText() -> String{
        if releasable(){
            return "Release"
        }
        if !hasReview(){
            return "Release"
        }
        return "Released"
    }
    
    func hasReview() -> Bool{
        return subLink.submission.reviews.contains(where: {$0.ready})
    }
    
    func releasable() -> Bool{
        if !hasReview(){
            return false
        }
        if subLink.submission.status == Submission.Status.approved {
            return false
        }
        if subLink.submission.status == Submission.Status.rejected {
            return false
        }
        
        return true
    }
}

