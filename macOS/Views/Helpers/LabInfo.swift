//
//  LabInfo.swift
//  Quickfeed
//

import SwiftUI

struct LabInfo: View {
    var submission: Submission
    var assignment: Assignment
    var teacherView: Bool
    
    var body: some View {
        VStack{
            HStack{
                Text("Status")
                Spacer()
                Text(translateSubmissionStatus(statusCode: submission.status))
                    .foregroundColor(getColorForSubmissionStatus(submissionStatus: submission.status))
            }
            Divider()
            HStack{
                Text("Tests passed")
                Spacer()
                Text("\(passed()) / \(submission.scoreObj!.count)")
                
            }
            .padding(.top, 1.0)
            Divider()
            HStack{
                Text("Execution time")
                Spacer()
                Text("\(String(format: "%.3f", Double(submission.buildInfoJSON.execTime) / 1000)) seconds")
            }
            .padding(.top, 1.0)
            Divider()
            HStack{
                Text("Delivered")
                Spacer()
                Text(date(date: submission.buildInfoJSON.builddate))
            }
            .padding(.top, 1.0)
            Divider()
            if submission.status == Submission.Status.approved && submission.approvedDate != "" {
                HStack{
                    Text("Approved")
                    Spacer()
                    Text(date(date: submission.approvedDate))
                }
                .padding(.top, 1.0)
                Divider()
            }
            HStack{
                Text("Deadline")
                Spacer()
                Text(date(date: assignment.deadline))
                
            }
            .padding(.top, 1.0)
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


