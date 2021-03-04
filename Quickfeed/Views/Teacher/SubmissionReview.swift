//
//  SubmissionReview.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 03/03/2021.
//

import SwiftUI

struct SubmissionReview: View {
    var user: User
    @ObservedObject var viewModel: TeacherViewModel
    @State var submissionLink: SubmissionLink
    @Binding var selectedLab: UInt64
    
    var body: some View {
        VStack{
            Text("\(user.name)'s submission for \(submissionLink.assignment.name)")
                .font(.headline)
                .padding(2)
            
            SubmissionInfo(viewModel: viewModel, submissionLink: $submissionLink)
                .padding(.horizontal, 100)
            
            
            
            
            List{
                Section(header: Text("Review")){
                    
                }
                ForEach(self.viewModel.assignmentMap[submissionLink.assignment.id]?.gradingBenchmarks ?? [], id: \.self){ benchmark in
                    
                    Section(header: Text(benchmark.heading)){
                        ForEach(benchmark.criteria, id: \.self){ crit in
                            HStack{
                                Text(crit.description_p)
                                Spacer()
                                Text("\(crit.grade.rawValue)")
                            }
                            Divider()
                            
                        }
                    }
                    
                }
                
            }
            
        }
        .padding(5)
        
        Spacer()
        
    }
}

struct SubmissionReview_Previews: PreviewProvider {
    static var previews: some View {
        SubmissionReview(user: User(), viewModel: TeacherViewModel(provider: FakeProvider(), course: Course()), submissionLink: SubmissionLink(), selectedLab: .constant(0))
    }
}
