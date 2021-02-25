//
//  ResultListItem.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 23/02/2021.
//

import SwiftUI

struct ResultListItem: View {
    var user: User
    var body: some View {
        HStack{
            Text(user.name)
                .frame(width: 180)
            Spacer()
            Text("95%")
            Spacer()
            Text("95%")
            Spacer()
            Text("95%")
            Spacer()
            Text("95%")
        }
        
    }
}

struct ResultListItem_Previews: PreviewProvider {
    static var previews: some View {
        ResultListItem(user: User(name: "Test User", id: 1, studentID: "111111", isAdmin: false, email: "gfkjdsl@dfsa.com", enrollments: [], login: "oskargj"))
    }
}
