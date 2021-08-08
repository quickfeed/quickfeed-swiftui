//
//  GradingBenchmarkHeader.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 20/04/2021.
//

import SwiftUI

struct GradingBenchmarkHeader: View {
    @ObservedObject var viewModel: TeacherViewModel
    @Binding var review: Review
    @Binding var comment: String
    @State private var addingComment = false
    var header: String
    
    var body: some View {
        HStack{
            Text(header)
            Spacer()
            if addingComment{
                TextField("add comment", text: $comment)
            }
            Button(action: {
                addingComment = !addingComment
                viewModel.updateReview(review: review)
            }, label: {
                Image(systemName: comment.isEmpty ? "bubble.left" : "bubble.left.fill")
            })
            .buttonStyle(PlainButtonStyle())
            
        }
        
    }
}

