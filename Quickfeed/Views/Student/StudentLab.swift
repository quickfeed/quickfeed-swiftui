//
//  StudentLab.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 08/02/2021.
//

import SwiftUI

struct StudentLab: View {
    var assignment: Assignment
    @ObservedObject var viewModel: StudentViewModel
    var submission: Submission? { return viewModel.getSubmission(assignment: assignment) }
    
    private func color() -> Color {
        switch (submission!.status){
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
        if submission == nil {
            Text("\(assignment.name) has no submission yet ")
        } else {
            ScrollView{
                Text(assignment.name)
                    .font(.title)
                    .fontWeight(.bold)
                Text("\(submission!.score)% Completed")
                ProgressView(value: Float(submission!.score), total: 100)
                    .accentColor(color())
                Divider()
                if assignment.skipTests {
                    ManuallyGraded()
                } else {
                    AutoGraded(assignment: assignment, submission: submission!)
                }
            }
            .padding()
        }
    }
}

struct StudentLab_Previews: PreviewProvider {
    static var previews: some View {
        let provider = FakeProvider()
        let assignment = provider.getAssignments(courseID: 111)[0]
        StudentLab(assignment: assignment, viewModel: StudentViewModel(provider: FakeProvider(), course: Course()))
    }
}
