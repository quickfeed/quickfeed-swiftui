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
    
    var body: some View {
        if submission == nil {
            Text("\(assignment.name) has no submission yet ")
        } else {
            VStack{
                Text(assignment.name)
                    .font(.title)
                    .fontWeight(.bold)
                Text("\(submission!.score)% Completed")
                ProgressView(value: Float(submission!.score), total: 100)
                    .accentColor(getColorForSubmissionStatus(submissionStatus: submission!.status))
                Divider()
                ScrollView{
                    if assignment.skipTests {
                        ManuallyGraded(submission: submission!)
                    } else {
                        AutoGraded(assignment: assignment, submission: submission!)
                    }
                }
                .frame(minHeight: 500, maxHeight: .infinity)
                
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
