//
//  GradingCriteriaListItem.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 05/03/2021.
//

import SwiftUI
import AppKit
import SwiftUIX

struct GradingCriterionListItem: View {
    @ObservedObject var viewModel: TeacherViewModel
    @Binding var crit: GradingCriterion
    @State private var addingComment = false
    @Binding var  review: Review
    var body: some View {
        VStack{
            HStack{
                Text(crit.description_p)
                Spacer()
                Divider()
                CriterionStatusControl(criterionStatus: $crit.grade)
                    .environmentObject(viewModel)
                    .onChange(of: crit.grade, perform: { value in
                        viewModel.updateReview(review: review)
                    })
                Divider()
                Button(action: {addingComment = !addingComment}, label: {
                    Image(systemName: crit.comment.isEmpty ? "bubble.left" : "bubble.left.fill")
                })
                .buttonStyle(PlainButtonStyle())
            }
            if addingComment{
                HStack{
                    TextField("add comment", text: $crit.comment)
                        .padding(.horizontal)
                    Spacer()
                    Button(action: {
                        self.addingComment = false
                        viewModel.updateReview(review: review)
                    }, label: {
                        Text("Save")
                    })
                }
               
            }
        }
    }
}

