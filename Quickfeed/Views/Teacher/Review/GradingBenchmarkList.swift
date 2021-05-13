//
//  GradingList.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 28/04/2021.
//

import SwiftUI

struct GradingBenchmarkList: View {
    @ObservedObject var viewModel: TeacherViewModel
    @State var review: Review
    @State var isCreated: Bool
    @State private var isEdited = false

    var body: some View {
        if isCreated{
            List {
                ForEach(self.review.benchmarks.indices, id: \.self){ idx in
                    GradingBenchmarkSection(viewModel: viewModel,
                                            benchmark: $review.benchmarks[idx],
                                            review: $review)
                }
            }
            .onChange(of: review) { newValue in
                isEdited = true
            }
            HStack{
                Spacer()
                Button(action: {
                    viewModel.updateReview(review: review)
                    viewModel.loadEnrollmentLinks()
                }, label: {
                    Text("Save Changes")
                })
                .disabled(isEdited ? false : true)
                Button(action: {
                    review.ready = true
                    viewModel.updateReview(review: review)
                }, label: {
                    Text("Mark as Ready")
                })
            }
        } else {
            CreateReview(viewModel: viewModel, review: $review, isCreated: $isCreated)
        }
    }
}
