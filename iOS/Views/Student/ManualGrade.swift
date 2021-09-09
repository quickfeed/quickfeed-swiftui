//
//  ManualGrade.swift
//  QuickFeed (iOS)
//
//  Created by Bjørn Kristian Teisrud on 02/08/2021.
//

import SwiftUI

struct ManualGrade: View {
    var reviews: [Review]
    
    var body: some View {
        ForEach(reviews, id: \.self){ review in
            if review.feedback != "" {
                Text("\(review.feedback)")
                    .foregroundColor(.secondary)
            }
        }
        List{
            ForEach(reviews[0].benchmarks, id: \.self){ benchmarks in
                Section(header: Text(benchmarks.heading)){
                    ForEach(getBenchmarkComments(reviews: reviews, index: reviews[0].benchmarks.firstIndex(of: benchmarks)!), id: \.self){ comment in
                        HStack{
                            Spacer()
                                .frame(width: 50)
                            Text("Comment: \(comment)")
                                .foregroundColor(.secondary)
                                .padding(.leading)
                        }
                    }
                    ForEach(benchmarks.criteria, id: \.self){ criteria in
                        VStack(alignment: .leading){
                            HStack{
                                Text(String(criteria.description_p))
                                Spacer()
                                ForEach(getCriteriaGrade(reviews: reviews, benchmarkIndex: reviews[0].benchmarks.firstIndex(of: benchmarks)!, criteriaIndex: reviews[0].benchmarks[reviews[0].benchmarks.firstIndex(of: benchmarks)!].criteria.firstIndex(of: criteria)!), id: \.self){ grade in
                                    getImageForGradingCriterionGrade(grade: grade)
                                        .foregroundColor(getColorForGradingCriterionGrade(grade: grade))
                                }
                            }
                            ForEach(getCriteriaComments(reviews: reviews, benchmarkIndex: reviews[0].benchmarks.firstIndex(of: benchmarks)!, criteriaIndex: reviews[0].benchmarks[reviews[0].benchmarks.firstIndex(of: benchmarks)!].criteria.firstIndex(of: criteria)!), id: \.self){ comment in
                                Text("")
                                Text("Comment: \(comment)")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding(.leading)
                }
            }
        }
        .cornerRadius(10)
        
    }
}
