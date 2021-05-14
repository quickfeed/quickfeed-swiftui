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
    @State var selectedSubStatus: Submission.Status = .none
    
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
                    .onAppear(perform: {
                        selectedSubStatus = submissionLink!.submission.status
                    })
                Spacer()
                HStack{
                    Picker(selection: $selectedSubStatus, label: Text("Picker"), content: {
                        Text("Approve").tag(Submission.Status.approved)
                            .foregroundColor(getColorForSubmissionStatus(submissionStatus: .approved))
                        Text("Revision").tag(Submission.Status.revision)
                            .foregroundColor(getColorForSubmissionStatus(submissionStatus: .revision))
                        Text("Reject").tag(Submission.Status.rejected)
                            .foregroundColor(getColorForSubmissionStatus(submissionStatus: .rejected))
                    })
                    .help("NOT IMPLEMENTED")
                    
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                    Button(action: {
                        
                    }, label: {
                        Text("Release")
                            .help("NOT IMPLEMENTED")
                    })
                }
                .padding()
            } else{
                Text("Missing submission")
            }
        }
    }
}
