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
    var slipdays: UInt32?
    
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
    
    private func color() -> Color {
        switch (submission.status){
        case Submission.Status.approved:
            return .green
        case Submission.Status.rejected:
            return .red
        case Submission.Status.revision:
            return .orange
        default:
            return .blue
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
                    .foregroundColor(color())
            }
            HStack{
                Text("Delivered")
                Spacer()
                Text(date(date: submission.buildInfoJSON.builddate))
            }
            .padding(.top, 1.0)
            if showApprovedLine() {
                HStack{
                    Text("Approved")
                    Spacer()
                    Text(date(date: submission.approvedDate))
                }
                .padding(.top, 1.0)
            }
            HStack{
                Text("Deadline")
                Spacer()
                Text(date(date: assignment.deadline))
                
            }
            .padding(.top, 1.0)
            HStack{
                Text("Tests passed")
                Spacer()
                Text("\(passed()) / \(submission.scoreObj!.count)")
                
            }
            .padding(.top, 1.0)
            HStack{
                Text("Execution time")
                Spacer()
                Text("\(String(format: "%.3f", Double(submission.buildInfoJSON.execTime) / 1000)) seconds")
            }
            .padding(.top, 1.0)
            if slipdays != nil && !assignment.isGroupLab {
                HStack{
                    Text("Slip days")
                    Spacer()
                    Text(String(slipdays!))
                    
                }
                .padding(.top, 1.0)
            }
        }
    }
}

struct LabInfo_Previews: PreviewProvider {
    static var previews: some View {
        let provider = FakeProvider()
        let slipdays = provider.getCourses()[0].slipDays
        let assignment = provider.getAssignments(courseID: 111)[0]
        let submission = provider.getAssignments(courseID: 111)[0].submissions[0]
        LabInfo(submission: submission, assignment: assignment, teacherView: false, slipdays: slipdays)
    }
}
