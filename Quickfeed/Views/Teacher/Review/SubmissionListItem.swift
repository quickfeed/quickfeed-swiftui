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
    
   
    var body: some View {
        HStack{
            Text(submitterName)
                .frame( width: 200, alignment: .leading)
            Spacer()
            Image(systemName: getImageSysNameForSubmissionStatus(status: subLink.submission.status))
                .foregroundColor(getColorForSubmissionStatus(submissionStatus: subLink.submission.status))
        }
        .help(reviewer)
    }
}
