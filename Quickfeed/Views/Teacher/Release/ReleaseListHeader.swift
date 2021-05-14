//
//  ReleaseListHeader.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 13/05/2021.
//

import SwiftUI

struct ReleaseListHeader: View {
    var body: some View {
        HStack{
            Text("Name")
                .frame(width: 200, alignment: .leading)
            Spacer()
            Text("Reviews")
                .frame(width: 200, alignment: .leading)
            Spacer()
            Text("Reviewer")
                .frame(width: 200, alignment: .leading)
            Spacer()
            Text("Status")
                .frame(width: 50, alignment: .leading)
            Spacer()
            Text("")
                .frame(width: 100, alignment: .leading)
        }
    }
}
