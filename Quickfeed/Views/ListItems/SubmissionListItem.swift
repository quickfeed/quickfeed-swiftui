//
//  SubmissionListItem.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 10/02/2021.
//

import SwiftUI

struct SubmissionListItem: View {
    var submitterName: String
    var totalReviewers: Int32
    var reviews: Int32
    var markedAsReady: Bool
    
    
    var body: some View {
        HStack{
            Text(submitterName)
                .frame(width: 200, alignment: .leading)
            Text("\(reviews) / \(totalReviewers)")
            if markedAsReady {
                Image(systemName: "checkmark.circle.fill")
            }
            
        }
    }
}

struct SubmissionListItem_Previews: PreviewProvider {
    static var previews: some View {
        SubmissionListItem(submitterName: "Ola Nordmann", totalReviewers: 1, reviews: 1, markedAsReady: true)
    }
}
