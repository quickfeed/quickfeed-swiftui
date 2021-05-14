//
//  SubmissionScore.swift
//  Quickfeed
//

import SwiftUI

struct SubmissionScore: View {
    var assignment: Assignment
    var submissionScore: uint32
    var submissionStatus: Submission.Status
    
    var body: some View {
        Text(assignment.name)
            .font(.title)
            .fontWeight(.bold)
        Text("\(submissionScore)% Completed")
        ZStack{
            if !(submissionStatus == Submission.Status.approved || submissionStatus == Submission.Status.rejected){
                ProgressView(value: Float(assignment.scoreLimit), total: 100)
                    .accentColor(Color(NSColor(named: "ScoreLimit")!))
            }
            ProgressView(value: Float(submissionScore > 100 ? 100 : submissionScore), total: 100)
                .accentColor(getColorForSubmissionStatus(submissionStatus: submissionStatus))
        }
    }
}
