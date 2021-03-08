//
//  GradingCriteriaListItem.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 05/03/2021.
//

import SwiftUI

struct GradingCriterionListItem: View {
    @Binding var crit: GradingCriterion
    @State private var addingComment = false
    
    var body: some View {
        VStack{
            HStack{
                Text(crit.description_p)
                Spacer()
                
                Divider()
                CriterionStatusControl(criterionStatus: $crit.grade)
                Divider()
                Button(action: {addingComment = !addingComment}, label: {
                    Image(systemName: crit.comment.isEmpty ? "bubble.left" : "bubble.left.fill")
                })
                .buttonStyle(PlainButtonStyle())
            }
            if addingComment{
                TextField("Add a comment", text: $crit.comment)
                    .padding(.horizontal)
            }
        }
       
        
    }
}

struct GradingCriteriaListItem_Previews: PreviewProvider {
    static var previews: some View {
        GradingCriterionListItem(crit: .constant(GradingCriterion()))
    }
}
