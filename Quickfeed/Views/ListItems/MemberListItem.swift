//
//  MemberListItem.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 22/02/2021.
//

import SwiftUI

struct MemberListItem: View {
    var enrollment: Enrollment
    var course: Course
    
    var body: some View {
        HStack {
            Link(enrollment.user.name, destination: URL(string: "https://www.github.com/" + course.organizationPath + "/" + enrollment.user.login + "-labs")!)
                .frame(minWidth: 200, maxWidth: .infinity, alignment: .leading)
            Text(enrollment.user.studentID)
                .frame(idealWidth: 50, maxWidth: .infinity, alignment: .leading)
            Link(enrollment.user.email, destination: URL(string: "mailto:" + enrollment.user.email)!)
                .frame(minWidth: 200, maxWidth: .infinity, alignment: .leading)
            Text("\(enrollment.lastActivityDate != "" ? enrollment.lastActivityDate : "Inactive")")
                .frame(idealWidth: 50, maxWidth: .infinity, alignment: .leading)
            Text("\(enrollment.totalApproved)")
                .frame(idealWidth: 50, maxWidth: .infinity, alignment: .leading)
            if course.slipDays > 0 {
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
        MemberListItem(enrollment: Enrollment(), course: Course())
    }
}
