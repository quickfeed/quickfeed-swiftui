//
//  SubmissionResult.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 23/02/2021.
//

import SwiftUI

struct SubmissionResult: View {
    @Binding var displayingSubmission: Bool
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button("Back"){self.displayingSubmission = false}
    }
}

struct SubmissionResult_Previews: PreviewProvider {
    static var previews: some View {
        SubmissionResult(displayingSubmission: .constant(true))
    }
}
