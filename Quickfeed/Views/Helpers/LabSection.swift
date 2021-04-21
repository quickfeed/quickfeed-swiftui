//
//  LabSection.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 08/02/2021.
//

import SwiftUI

struct LabSection: View {
    @ObservedObject var viewModel: StudentViewModel
    var assignments: [Assignment]? { return viewModel.assignments }
    //@State private var activeDest: Int? = 0
    
    var body: some View {
        if assignments == nil {
            Text("No Assignments yet")
        } else {
            Section(header: Text("Labs")){
                ForEach(assignments!, id: \.id){ assignment in
                    NavigationLink(destination: StudentLab(viewModel: viewModel, assignment: assignment, submission: viewModel.getSubmission(assignment: assignment))){
                        if viewModel.getSubmission(assignment: assignment) != nil {
                            getImageForSubmissionStatus(submission: viewModel.getSubmission(assignment: assignment)!.status)
                                .frame(width: 5)
                                .foregroundColor(getColorForSubmissionStatus(submissionStatus: viewModel.getSubmission(assignment: assignment)!.status))
                        }
                        Text(assignment.name)
                        Spacer()
                        if assignment.isGroupLab {
                            Image(systemName: "person.3.fill")
                        }
                    }
                }
                .padding(.leading)
            }
        }
    }
}

