//
//  SwiftUIView.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 26/03/2021.
//

import SwiftUI

struct SwiftUIView: View {
    var review: [Review]
    var benchmarks: [GradingBenchmark]
    var benchmarkCriteria: [GradingCriterion]
    
    init(reviews: [Review]){
        self.review = getReadyReviews(reviews: reviews)
        var benchmarks: [GradingBenchmark] = []
        for review in self.review {
            benchmarks.append(contentsOf: review.benchmarks)
        }
        self.benchmarks = benchmarks
        var criteria: [GradingCriterion] = []
        for benchmark in self.benchmarks {
            criteria.append(contentsOf: benchmark.criteria)
        }
        self.benchmarkCriteria = criteria
    }
    
    var body: some View {
        List{
            ForEach(review[0].benchmarks, id: \.self){ benchmarks in
                Section(header: Text(benchmarks.heading)){
                    if benchmarks.comment != "" {
                        HStack{
                            Spacer()
                                .frame(width: 50)
                            Text("Comment: \(benchmarks.comment)")
                                .foregroundColor(.secondary)
                                .padding(.leading)
                        }
                        Divider()
                        .padding(.leading)
                    }
                    ForEach(benchmarks.criteria, id: \.self){ criteria in
                        HStack{
                            Text(String(criteria.description_p))
                            Spacer()
                            getImageForGradingCriterionGrade(grade: criteria.grade)
                                .foregroundColor(getColorForGradingCriterionGrade(grade: criteria.grade))
                        }
                        if criteria.comment != "" {
                            HStack{
                                Spacer()
                                    .frame(width: 50)
                                Text("Comment: \(criteria.comment)")
                                    .foregroundColor(.secondary)
                            }
                        }
                        Divider()
                    }
                    .padding(.leading)
                }
            }
            if getReview(reviews: review) != nil {
                Section(header: Text("Feedback")){
                    ForEach(getReview(reviews: review)!.indices){ feedback in
                        Text("Comment: \(feedback)")
                            .foregroundColor(.secondary)
                            .padding(.leading)
                    }
                }
            }
        }
        .cornerRadius(5)
    }
}

/*struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
*/
