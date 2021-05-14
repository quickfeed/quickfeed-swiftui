//
//  ReleaseSheet.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 13/05/2021.
//

import SwiftUI

struct ReleaseSheet: View {
    @EnvironmentObject var viewModel: TeacherViewModel
    @Binding var selectedLab: UInt64
    @Binding var enrollmentLink: EnrollmentLink?
    
    var submissionLink: SubmissionLink?{
        return enrollmentLink!.submissions.first(where: {$0.assignment.id == selectedLab})
    }
    
    var body: some View {
        if enrollmentLink == nil{
            Text("DEBUG: Enrollment not found")
        } else {
            if submissionLink != nil{
                StudentLab(viewModel: nil,
                           assignment: submissionLink!.assignment,
                           submission: submissionLink!.submission)
            } else{
                Text("Missing submission")
            }
        }
    }
}
