//
//  GradingList.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 28/04/2021.
//

import SwiftUI

struct GradingList: View {
    @ObservedObject var viewModel: TeacherViewModel
    @State var review: Review
    @State var isCreated: Bool

    var body: some View {
        if isCreated{
            List {
                ForEach(self.review.benchmarks.indices, id: \.self){ idx in
                    GradingBenchmarkSection(viewModel: viewModel,
                                            benchmark: $review.benchmarks[idx],
                                            review: $review)
                }
            }
            HStack{
                Spacer()
                Button(action: {
                    review.ready = true
                    viewModel.updateReview(review: review)
                    viewModel.loadEnrollmentLinks()
                }, label: {
                    Text("Mark as Ready")
                })
            }
        } else {
            CreateReview(viewModel: viewModel, review: $review, isCreated: $isCreated)
        }
    }
}
