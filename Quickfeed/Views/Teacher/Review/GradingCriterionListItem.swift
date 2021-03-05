//
//  GradingCriteriaListItem.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 05/03/2021.
//

import SwiftUI

struct GradingCriterionListItem: View {
    @Binding var crit: GradingCriterion
    
    var body: some View {
        HStack{
            Text(crit.description_p)
            Spacer()
            Divider()
            CriterionStatusControl(criterionStatus: $crit.grade)
        }
        Divider()
    }
}

struct GradingCriteriaListItem_Previews: PreviewProvider {
    static var previews: some View {
        GradingCriterionListItem(crit: .constant(GradingCriterion()))
    }
}
