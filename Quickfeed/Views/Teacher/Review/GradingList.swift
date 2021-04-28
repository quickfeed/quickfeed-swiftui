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
    var body: some View {
        if review.benchmarks.count > 0{
            List {
                ForEach(self.review.benchmarks.indices, id: \.self){ idx in
                    GradingBenchmarkSection(viewModel: viewModel,
                                            benchmark: $review.benchmarks[idx],
                                            review: $review)
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

                }
            }
        } else {
            HStack{
                Text("No reviews yet")
                Spacer()
                Button(action: {
                    
                }, label: {
                    Text("Create Review")
                })
            }
        }
        
    }
}
