//
//  SubmissionListHeader.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 03/03/2021.
//

import SwiftUI

struct SubmissionListHeader: View {
    var body: some View {
        HStack{
            Text("Submitter")
            Spacer()
            Text("Status")
        }
    }
}

struct SubmissionListHeader_Previews: PreviewProvider {
    static var previews: some View {
        SubmissionListHeader()
    }
}
