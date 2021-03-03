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
        Text("Feedback")
            .font(.title2)
            .fontWeight(.bold)
            .padding(.top)
        VStack(alignment: .leading){
            ForEach(review.benchmarks, id: \.self){ benchmarks in
                Section(header: Text(benchmarks.heading)){
                    ForEach(benchmarks.criteria, id: \.self){ criteria in
                        Text(String(criteria.points))
                        if criteria.comment != "" {
                            Text(criteria.comment)
                        }
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
