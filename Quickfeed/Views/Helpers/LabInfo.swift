//
//  LabInfo.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 08/02/2021.
//

import SwiftUI

struct LabInfo: View {
    var submission: Submission
    var assignment: Assignment
    var teacherView: Bool
    
    private func showApprovedLine() -> Bool {
        return submission.status == Submission.Status.approved && submission.approvedDate != ""
    }
    
    private func submissionStatusToString() -> String {
        switch (submission.status){
        case Submission.Status.approved:
            return "Approved"
        case Submission.Status.rejected:
            return "Rejected"
        case Submission.Status.revision:
            return "Revision"
        default:
            return "None"
        }
    }
    
    private func date(date: String) -> String{
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dateString = dateFormat.date(from: date)!
        
        let stringFormatter = DateFormatter()
        stringFormatter.dateFormat = "E, d MMM YY HH:mm"
        return stringFormatter.string(from: dateString)
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
    
    var body: some View {
        VStack{
            HStack{
                Text("Status")
                Spacer()
                Text(submissionStatusToString())
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
            if showApprovedLine() {
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
}


