//
//  AutoGrade.swift
//  QuickFeed (iOS)
//
//  Created by Bjørn Kristian Teisrud on 02/08/2021.
//

import SwiftUI

struct AutoGrade: View {
    var assignment: Assignment
    var submission: Submission
    
    var body: some View {
        ScrollView(showsIndicators: false){
            LabInfo(assignment: assignment, submission: submission)
            LabTests(submission: submission)
            LabFeedback(submission: submission)
        }
    }
}

struct LabTests: View {
    var submission: Submission
    
    var body: some View {
        Text("Tests")
            .font(.title2)
            .fontWeight(.bold)
            .padding(.vertical)
        ForEach(submission.scoreObj!, id: \.self) { scoreObject in
            HStack{
                Text(scoreObject.TestName)
                Spacer()
                Text("\(scoreObject.Score)/\(scoreObject.MaxScore)")
            }
            Divider()
        }
    }
}

struct LabInfo: View {
    var assignment: Assignment
    var submission: Submission
    
    var body: some View {
        Text("BuildInfo")
            .font(.title2)
            .fontWeight(.bold)
            .padding(.vertical)
        VStack{
            HStack{
                Text("Status")
                Spacer()
                Text(translateSubmissionStatus(statusCode: submission.status))
                    .foregroundColor(getColorForSubmissionStatus(submissionStatus: submission.status))
            }
            Divider()
            InfoRow(title: "Tests passed", info: "\(passed()) / \(submission.scoreObj!.count)")
            InfoRow(title: "Execution time", info: "\(String(format: "%.2f", Double(submission.buildInfoJSON.execTime) / 1000)) seconds")
            InfoRow(title: "Delivered", info: date(date: submission.buildInfoJSON.builddate))

            if submission.status == Submission.Status.approved && submission.approvedDate != "" {
                InfoRow(title: "Approved", info: date(date: submission.approvedDate))
            }
            InfoRow(title: "Deadline", info: date(date: assignment.deadline))
        }
        
    }
    
    private func passed() -> Int {
        var passed = 0
        if submission.scoreObj != nil{
            for object in submission.scoreObj! {
                if object.Score == object.MaxScore {
                    passed += 1
                }
            }
        }
        return passed
    }
}

struct InfoRow: View {
    var title: String
    var info: String
    
    var body: some View {
        HStack{
            Text(title)
            Spacer()
            Text(info)
        }
        Divider()
    }
}

struct LabFeedback: View {
    var submission: Submission
    var body: some View {
        Text("FeedBack")
            .font(.title2)
            .fontWeight(.bold)
            .padding(.vertical)
        ScrollView(showsIndicators: false){
            Text(submission.buildInfoJSON.buildlog)
        }
    }
}

