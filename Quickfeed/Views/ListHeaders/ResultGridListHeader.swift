//
//  ResultGridListHeader.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 03/03/2021.
//

import SwiftUI

struct ResultGridListHeader: View {
    var assignments: [Assignment]
    
    var body: some View {
        HStack{
            Text("Name:")
                .frame(width: 180, alignment: .leading)
            ForEach(assignments, id: \.self) {assignment in
                Text(assignment.name)
                    .frame(width: 90, alignment: .center)
                Spacer()
            }
        }
        .padding(2)
    }
}

struct ResultGridListHeader_Previews: PreviewProvider {
    static var previews: some View {
        ResultGridListHeader(assignments: [])
    }
}
