//
//  SubmissionScore.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 11/03/2021.
//

import SwiftUI

struct SubmissionScore: View {
    var assignmentName: String
    var submissionScore: uint32
    var submissionStatus: Submission.Status
    
    var body: some View {
        Text(assignmentName)
            .font(.title)
            .fontWeight(.bold)
        Text("\(submissionScore)% Completed")
        ProgressView(value: Float(submissionScore > 100 ? 100 : submissionScore), total: 100)
            .accentColor(getColorForSubmissionStatus(submissionStatus: submissionStatus))
    }
}

/*struct SubmissionScore_Previews: PreviewProvider {
    static var previews: some View {
        SubmissionScore()
    }
}*/
