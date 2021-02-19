//
//  StudentLab.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 08/02/2021.
//

import SwiftUI

struct StudentLab: View {
    var assignment: Assignment
    var slipdays: UInt32
    var submission: Submission { return assignment.submissions[0] }
    
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
    
    var body: some View {
        ScrollView{
            Text(assignment.name)
                .font(.title)
                .fontWeight(.bold)
            ProgressView(value: Float(submission.score), total: 100)
                .accentColor(color())
            Divider()
            HStack{
                Spacer()
                Text("Tests")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Text("Lab Information")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(width: 300)
            }
            .padding(.bottom, 1.0)
            HStack{
                LabTests(submission: submission)
                Divider()
                VStack{
                    LabInfo(submission: submission, assignment: assignment, teacherView: false, slipdays: slipdays)
                        .frame(width: 300)
                    Spacer()
                }
            }
            Divider()
            Text("Feedback")
                .font(.title2)
                .fontWeight(.bold)
            
            //TODO: ADD FEEDBACK FIELD
        }
        .padding()
    }
}

struct StudentLab_Previews: PreviewProvider {
    static var previews: some View {
        let provider = FakeProvider()
        let assignment = provider.getAssignments(courseID: 111)[0]
        let slipdays = provider.getCourses()[0].slipDays
        StudentLab(assignment: assignment, slipdays: slipdays)
    }
}
