//
//  GroupListHeader.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 18/03/2021.
//

import SwiftUI

struct GroupListHeader: View {
    var body: some View {
        HStack{
            Text("Name")
                .frame(width: 200, alignment: .leading)
            Spacer()
            Text("Members")
                .frame(width: 200, alignment: .leading)
            Spacer()
            Text("Status")
                .frame(width: 75, alignment: .leading)
        }
        
    }
}

struct GroupListHeader_Previews: PreviewProvider {
    static var previews: some View {
        GroupListHeader()
    }
}
