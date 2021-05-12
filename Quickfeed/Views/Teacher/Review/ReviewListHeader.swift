//
//  ReviewListHeader.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 06/05/2021.
//

import SwiftUI

struct ReviewListHeader: View {
    var body: some View {
        HStack(){
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
        }
    }
}

struct ReviewListHeader_Previews: PreviewProvider {
    static var previews: some View {
        ReviewListHeader()
    }
}
