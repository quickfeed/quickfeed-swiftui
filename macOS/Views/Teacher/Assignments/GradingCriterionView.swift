//
//  GradingCriterionView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 19/04/2021.
//

import SwiftUI

struct GradingCriterionView: View {
    @ObservedObject var viewModel: TeacherViewModel
    var assignment: Assignment
    var body: some View {
        HStack{
            Text("Grading Benchmarks")
                .font(.headline)
            Spacer()
            Button(action: {_ = viewModel.loadCriteria(assignmentId: assignment.id)}, label: {
                Text("Load From File")
            })
            .disabled(assignment.skipTests ? false : true)
        }
        .padding()
        if assignment.gradingBenchmarks.count > 0{
            List{
                ForEach(assignment.gradingBenchmarks, id: \.self){ benchmark in
                    Section(header: Text(benchmark.heading)){
                        ForEach(benchmark.criteria, id: \.self){ criterion in
                            Text(criterion.description_p)
                            Divider()
                        }
                    }
                }
            }
            .frame(minHeight: 100)
            .cornerRadius(10)
            Spacer()
        }
        Spacer()
    }
}
