//
//  StudentLab.swift
//  QuickFeed (iOS)
//
//  Created by Bjørn Kristian Teisrud on 02/08/2021.
//

import SwiftUI

struct StudentLab: View {
    var assignment: Assignment
    var submission: Submission?
    
    var body: some View {
        if submission == nil{
            Text("\(assignment.name) has no submission yet")
            Text("Deadline is \(date(date: assignment.deadline))")
        }else if assignment.skipTests && !submission!.released{
            Text("\(assignment.name) has a submission, but has not been graded yet")
        }else{
            VStack{
                LabHeader(assignment: assignment, submission: submission!)
                if assignment.skipTests{
                    //ManualGrade(reviews: getReadyReviews(reviews: submission!.reviews))
                }else {
                    AutoGrade(assignment: assignment, submission: submission!)
                }
                Spacer()
            }
            .padding([.leading, .bottom, .trailing])
        }
    }
}

struct LabHeader: View {
    var assignment: Assignment
    var submission: Submission
    
    var body: some View {
        Text(assignment.name)
            .font(.title)
            .fontWeight(.bold)
        Text("\(submission.score)%")
            .font(.subheadline)
        ZStack{
            if !(submission.status == Submission.Status.approved || submission.status == Submission.Status.rejected){
                ProgressView(value: Float(assignment.scoreLimit), total: 100)
                    .accentColor(Color("ScoreLimit"))
            }
            ProgressView(value: Float(submission.score > 100 ? 100 : submission.score), total: 100)
                .accentColor(getColorForSubmissionStatus(submissionStatus: submission.status))
        }
        Divider()
    }
}
