//
//  ManuallyGraded.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 03/03/2021.
//

import SwiftUI

struct ManuallyGraded: View {
    var submission: Submission
    var review: Review { return submission.reviews[0] }
    
    var body: some View {
        List{
            ForEach(review.benchmarks, id: \.self){ benchmarks in
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
            if review.feedback != "" {
                Section(header: Text("Feedback")){
                    Text("Comment: \(review.feedback)")
                        .foregroundColor(.secondary)
                        .padding(.leading)
                }
            }
        }
        .cornerRadius(5)
    }
}

/*struct ManuallyGraded_Previews: PreviewProvider {
 static var previews: some View {
 ManuallyGraded()
 }
 }*/
