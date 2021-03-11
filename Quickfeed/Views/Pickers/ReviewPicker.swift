//
//  ReviewPicker.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 11/03/2021.
//

import SwiftUI

struct ReviewPicker: View {
    var reviews: [Review]
    @Binding var selectedReview: Int
    var viewModel: TeacherViewModel?
    
    var body: some View {
        Picker("Convert", selection: $selectedReview) {
            ForEach(0 ..< reviews.count, id: \.self)
            { i in
                if viewModel != nil {
                    Text(viewModel!.getUserName(userId: reviews[i].reviewerID))
                } else {
                    Text("Reviewer \(i + 1)")
                }
            }
        }
        .labelsHidden()
        .pickerStyle(SegmentedPickerStyle())
    }
}

/*struct ReviewPicker_Previews: PreviewProvider {
    static var previews: some View {
        ReviewPicker()
    }
}*/
