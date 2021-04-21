//
//  StudentLab.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 08/02/2021.
//

import SwiftUI

struct StudentLab: View {
    var viewModel: StudentViewModel?
    var assignment: Assignment
    var submission: Submission?
    @State private var selectedReview: Int = 0
    
    var body: some View {
        if submission == nil {
            VStack{
                Text("\(assignment.name) has no submission yet")
                Text("Deadline is \(date(date: assignment.deadline))")
            }
            .frame(minWidth: 500, minHeight: 200)
            .navigationTitle("Student")
            .navigationSubtitle(assignment.name)
            .toolbar{
                Text(" ")
            }
        } else if submission!.released == false && assignment.skipTests == true{
            Text("\(assignment.name) has a submission, but has not been graded yet")
        } else {
            VStack{
                SubmissionScore(assignment: assignment, submissionScore: submission!.score, submissionStatus: submission!.status)
                Divider()
                if assignment.skipTests {
                    ManuallyGraded(reviews: getReadyReviews(reviews: submission!.reviews))
                } else {
                    AutoGraded(assignment: assignment, submission: submission!)
                }
                
            }
            .padding()
            .navigationTitle(viewModel != nil ? viewModel!.user.name : "Student")
            .navigationSubtitle(assignment.name)
            .toolbar{
                Text(" ")
            }
        }
    }
}

/*struct StudentLab_Previews: PreviewProvider {
 static var previews: some View {
 let provider = FakeProvider()
 let assignment = provider.getAssignments(courseID: 111)[0]
 StudentLab(assignment: assignment, viewModel: StudentViewModel(provider: FakeProvider(), course: Course()))
 }
 }*/
