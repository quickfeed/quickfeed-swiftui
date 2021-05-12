//
//  ReviewSheet.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 12/05/2021.
//

import SwiftUI

struct ReviewSheet: View {
    @EnvironmentObject var viewModel: TeacherViewModel
    var selectedLab: UInt64
    @Binding var enrollmentLink: EnrollmentLink?
    
    var body: some View {
        if enrollmentLink == nil{
            Text("DEBUG: Enrollment not found")
        } else {
            SubmissionReview(viewModel: viewModel,
                             submissionLink: enrollmentLink!.submissions.first(where: {$0.assignment.id == selectedLab})!,
                             user: enrollmentLink!.enrollment.user)
        }
    }
}

