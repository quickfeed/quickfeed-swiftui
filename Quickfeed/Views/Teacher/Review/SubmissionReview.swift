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
    @State private var review: Review = Review()
    
    var body: some View {
        VStack{
            Text("\(user.name)'s submission for \(submissionLink.assignment.name)")
                .font(.title)
                .fontWeight(.bold)
            SubmissionInfo(viewModel: viewModel, submissionLink: $submissionLink)
                .padding(.horizontal, 100)
            List{
                ForEach(self.review.benchmarks.indices, id: \.self){ idx in
                    GradingBenchmarkSection(benchmark: $review.benchmarks[idx])
                }
            }
            .cornerRadius(5)
            Spacer()
            
        }
        .padding()
        .onAppear(perform:{
            print("test")
            self.review = submissionLink.submission.reviews.first ?? Review()
        })
        
        
        
    }
}

struct SubmissionReview_Previews: PreviewProvider {
    static var previews: some View {
        SubmissionReview(user: User(), viewModel: TeacherViewModel(provider: FakeProvider(), course: Course()), submissionLink: SubmissionLink(), selectedLab: .constant(0))
    }
}
