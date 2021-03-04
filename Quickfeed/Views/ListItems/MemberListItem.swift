//
//  MemberListItem.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 22/02/2021.
//

import SwiftUI

struct MemberListItem: View {
    var enrollment: Enrollment
    var courseTotalSlipDays: UInt32
    
    var body: some View {
        HStack {
            Text(enrollment.user.name)
                .padding(.leading, 4)
                .frame(minWidth: 200, maxWidth: .infinity, alignment: .leading)
            Link(enrollment.user.email, destination: URL(string: "mailto:" + enrollment.user.email)!)
                .frame(minWidth: 200, maxWidth: .infinity, alignment: .leading)
            Text(enrollment.user.studentID)
                .frame(idealWidth: 50, maxWidth: .infinity, alignment: .leading)
            Text("\(enrollment.lastActivityDate != "" ? enrollment.lastActivityDate : "Inactive")")
                .frame(idealWidth: 50, maxWidth: .infinity, alignment: .leading)
            Text("\(enrollment.totalApproved)")
                .frame(idealWidth: 50, maxWidth: .infinity, alignment: .leading)
            if courseTotalSlipDays > 0 {
                Text("\(enrollment.slipDaysRemaining)")
                    .frame(idealWidth: 50, maxWidth: .infinity, alignment: .leading)
            }
            Text(translateUserStatus(status: enrollment.status))
                .frame(idealWidth: 50, maxWidth: .infinity, alignment: .leading)
            
        }
    }
}

struct MemberListItem_Previews: PreviewProvider {
    static var previews: some View {
        MemberListItem(enrollment: Enrollment(), courseTotalSlipDays: 2)
    }
}
