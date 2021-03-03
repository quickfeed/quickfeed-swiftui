//
//  MemberListHeader.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 03/03/2021.
//

import SwiftUI

struct MemberListHeader: View {
    var body: some View {
        HStack{
            Text("Name")
                .padding(.leading, 4)
                .frame(minWidth: 200, maxWidth: .infinity, alignment: .leading)
            Text("Email")
                .frame(minWidth: 200, maxWidth: .infinity, alignment: .leading)
            Text("Student ID")
                .frame(idealWidth: 50, maxWidth: .infinity, alignment: .leading)
            Text("Activity")
                .frame(idealWidth: 50, maxWidth: .infinity, alignment: .leading)
            Text("Approved")
                .frame(idealWidth: 50, maxWidth: .infinity, alignment: .leading)
            Text("Role")
                .frame(idealWidth: 50, maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct MemberListHeader_Previews: PreviewProvider {
    static var previews: some View {
        MemberListHeader()
    }
}
