//
//  StudentLab.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 08/02/2021.
//

import SwiftUI

struct StudentLab: View {
    var assignment: Assignment
    var submission: Submission?
    @State private var selectedReview: Int = 0
    
    var body: some View {
        if submission == nil {
            Text("\(assignment.name) has no submission yet ")
        } else if submission!.released == false && assignment.skipTests == true{
            Text("\(assignment.name) has a submission, but has not been graded yet")
        } else {
            VStack{
                SubmissionScore(assignment: assignment, submissionScore: submission!.score, submissionStatus: submission!.status)
                Divider()
                if assignment.skipTests {
                    if submission!.reviews.count > 1{
                        ReviewPicker(reviews: submission!.reviews, selectedReview: $selectedReview, viewModel: nil)
                    }
                    ManuallyGraded(submission: submission!, review: submission!.reviews[selectedReview])
                } else {
                    AutoGraded(assignment: assignment, submission: submission!)
                }
                
            }
            .padding()
            .navigationTitle("Student")
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
