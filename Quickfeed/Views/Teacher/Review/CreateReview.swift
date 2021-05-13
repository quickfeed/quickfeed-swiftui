//
//  CreateReview.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 28/04/2021.
//

import SwiftUI

struct CreateReview: View {
    @ObservedObject var viewModel: TeacherViewModel
    @Binding var review: Review
    @Binding var isCreated: Bool
    
    var body: some View {
        HStack{
            Spacer()
            Button(action: {
                let createdReview = viewModel.createReview(review: review)
                if createdReview != nil{
                    review = createdReview!
                    isCreated = true
                }
            }, label: {
                Text("Create Review")
            })
        }
    }
}
