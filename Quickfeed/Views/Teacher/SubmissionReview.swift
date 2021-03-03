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
                ForEach(submissionLink.submission.reviews.first?.benchmarks ?? [], id: \.self){ benchmark in
                    
                    Section(header: Text(benchmark.heading)){
                        Text("test")
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
        SubmissionReview(user: User(), viewModel: TeacherViewModel(provider: FakeProvider(), course: Course()), submissionLink: SubmissionLink())
    }
}
