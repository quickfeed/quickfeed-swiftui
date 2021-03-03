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
    
    
    var body: some View {
        HStack{
            Text(submitterName)
                .frame( width: 200, alignment: .leading)
            Spacer()
            Image(systemName: statusSymbol())
        }
    }
    
    
    func statusSymbol() -> String{
        if !subLink.hasSubmission{
            return "questionmark.circle"
        }
        
        return subLink.submission.reviews.last?.ready ?? false ? "checkmark.circle" : "circle"
    }
}

struct SubmissionListItem_Previews: PreviewProvider {
    static var previews: some View {
        List{
            SubmissionListItem(submitterName: "Ola Nord", subLink: SubmissionLink())
        }
        .frame(alignment: .leading)
        
    }
}
