//
//  GradingBenchmarkSection.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 05/03/2021.
//

import SwiftUI

struct GradingBenchmarkSection: View {
    @ObservedObject var viewModel: TeacherViewModel
    @Binding var benchmark: GradingBenchmark
    @Binding var review: Review
    
    
    var body: some View {
        Section(header: GradingBenchmarkHeader(viewModel: viewModel, review: $review, comment: $benchmark.comment, header: benchmark.heading)){
            ForEach(benchmark.criteria.indices, id: \.self){ idx in
                GradingCriterionListItem(viewModel: viewModel, crit: $benchmark.criteria[idx], review: $review)
                Divider()
            }
        }
    }
}
