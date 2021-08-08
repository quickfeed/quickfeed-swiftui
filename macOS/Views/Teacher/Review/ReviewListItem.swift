//
//  SubmissionListItem.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 10/02/2021.
//

import SwiftUI


struct ReviewListItem: View {
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
                    }
                } else{
                    Text("N/A")
                }
            }
            .frame(width: 200, alignment: .leading)
            Spacer()
            Image(systemName: getImageSysNameForSubmissionStatus(status: subLink.submission.status))
                .foregroundColor(getColorForSubmissionStatus(submissionStatus: subLink.submission.status))
        }
    }
}
