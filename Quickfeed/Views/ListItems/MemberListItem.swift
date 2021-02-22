//
//  MemberListItem.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 22/02/2021.
//

import SwiftUI

struct MemberListItem: View {
    var user: User
    
    var body: some View {
        HStack {
            Text(user.name)
                .padding(.leading, 4)
                .frame(minWidth: 200, maxWidth: .infinity, alignment: .leading)
            Link(user.email, destination: URL(string: "mailto:" + user.email)!)
                .frame(minWidth: 200, maxWidth: .infinity, alignment: .leading)
            Text(user.studentID)
                .frame(idealWidth: 50, maxWidth: .infinity, alignment: .leading)
            Text("Inactive") // NOT IMPLEMENTED
                .frame(idealWidth: 50, maxWidth: .infinity, alignment: .leading)
            Text("0") // NOT IMPLEMENTED
                .frame(idealWidth: 50, maxWidth: .infinity, alignment: .leading)
            Text("Student") // NOT IMPLEMENTED
                .frame(idealWidth: 50, maxWidth: .infinity, alignment: .leading)

        }
    }
}

struct MemberListItem_Previews: PreviewProvider {
    static var previews: some View {
        MemberListItem(user: User(name: "Oskar Skjærvø Gjølga", id: 1, studentID: "123456", isAdmin: false, email: "os.gjolga@stud.uis.no", enrollments: [], login: "oskargj"))
    }
}
