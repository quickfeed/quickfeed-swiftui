//
//  ResultListItem.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 23/02/2021.
//

import SwiftUI

struct ResultListItem: View {
    @ObservedObject var viewModel: TeacherViewModel
    var user: User
    var submissionLinks: [SubmissionLink]
    @Binding var displayedSubmissionLink: SubmissionLink?
    var body: some View {
        HStack{
            Text(user.name)
                .frame(width: 180, alignment: .leading)
            
            ForEach(submissionLinks, id: \.assignment.id){ link in
                Spacer()
                if link.hasSubmission{
                Button(action: {
                    
                    displayedSubmissionLink = viewModel.getSubmissionLink(userId: user.id, submissionId: link.submission.id)
                    
                }) {
                    Text("\(link.submission.score)%")
                        .foregroundColor(getColorForSubmissionStatus(submissionStatus: link.submission.status))
                        .frame(width: 90, alignment: .center)
                }
                .buttonStyle(PlainButtonStyle())
                } else{
                    Text("N/A")
                        .foregroundColor(.secondary)
                        .frame(width: 90, alignment: .center)
                }
                
            }
        }
        
    }
}

