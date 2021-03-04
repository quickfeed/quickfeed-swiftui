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
    
    private func image(submission: Submission) -> Image{
        switch (submission.status){
        case Submission.Status.approved:
            return Image(systemName: "checkmark.circle")
        case Submission.Status.rejected:
            return Image(systemName: "multiply.circle")
        case Submission.Status.revision:
            return Image(systemName: "circlebadge")
        default:
            return Image(systemName: "circlebadge")
        }
    }
    
    private func color(submission: Submission) -> Color {
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
        if assignments == nil {
            Text("No Assignments yet")
        } else {
            Section(header: Text("Labs")){
                ForEach(assignments!, id: \.id){ assignment in
                    NavigationLink(destination: StudentLab(assignment: assignment, viewModel: viewModel)){
                        if viewModel.getSubmission(assignment: assignment) != nil {
                            image(submission: viewModel.getSubmission(assignment: assignment)!)
                                .frame(width: 5)
                                .foregroundColor(color(submission: viewModel.getSubmission(assignment: assignment)!))
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

struct LabSection_Previews: PreviewProvider {
    static var previews: some View {
        
        List{
            LabSection(viewModel: StudentViewModel(provider: FakeProvider(), course: Course()))
        }
    }
}
