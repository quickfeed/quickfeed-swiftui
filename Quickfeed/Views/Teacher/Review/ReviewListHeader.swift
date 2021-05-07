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
            Spacer()
            Text("Reviews")
            Spacer()
            Text("Reviewer")
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
