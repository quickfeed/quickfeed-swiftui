//
//  GradingBenchmarkSection.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 05/03/2021.
//

import SwiftUI

struct GradingBenchmarkSection: View {
   @Binding var benchmark: GradingBenchmark
    
    var body: some View {
        Section(header: Text(benchmark.heading)){
            ForEach(benchmark.criteria.indices, id: \.self){ idx in
                GradingCriterionListItem(crit: $benchmark.criteria[idx])
                Divider()
            }
        }
    }
}

struct GradingBenchmarkSection_Previews: PreviewProvider {
    static var previews: some View {
        GradingBenchmarkSection(benchmark: .constant(GradingBenchmark()))
    }
}
