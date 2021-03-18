//
//  GroupListItem.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 18/03/2021.
//

import SwiftUI

struct GroupListItem: View {
    var group: Group
    var body: some View {
        HStack{
            Text(group.name)
                .frame(width: 200, alignment: .leading)
            Spacer()
            VStack(alignment: .leading){
                ForEach(group.enrollments, id: \.self){ enrollment in
                    Text(enrollment.user.name)
                }
            }
            .frame(width: 200, alignment: .leading)
            
            Spacer()
            Text("\(group.status.rawValue == 1 ? "Approved" : "Pending" )")
                .frame(width: 75, alignment: .leading)
        }
        
    }
}

struct GroupListItem_Previews: PreviewProvider {
    static var previews: some View {
        GroupListItem(group: Group())
    }
}
