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
            
        }
    }
}

/*struct ManuallyGraded_Previews: PreviewProvider {
 static var previews: some View {
 ManuallyGraded()
 }
 }*/
