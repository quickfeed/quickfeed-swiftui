//
//  SubmissionListItem.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 10/02/2021.
//

import SwiftUI

// Display submitter name and review status
struct SubmissionListItem: View {
    var submitterName: String
    var subLink: SubmissionLink
    var reviewer: String
    
    var reviews: Int {
        return subLink.submission.reviews.count
    }
    
    var body: some View {
        HStack{
            Text(submitterName)
                .frame(width: 200, alignment: .leading)
            Spacer()
            Text("\(reviews)/\(subLink.assignment.reviewers)")
                .frame(width: 200, alignment: .leading)
            Spacer()
            Text(reviewer)
                .frame(width: 200, alignment: .leading)
            Spacer()
            Image(systemName: getImageSysNameForSubmissionStatus(status: subLink.submission.status))
                .foregroundColor(getColorForSubmissionStatus(submissionStatus: subLink.submission.status))
        }
        .help(reviewer)
    }
}
