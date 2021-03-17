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
            SwiftUI.Group{
                Link(destination: URL(string: "https://www.github.com/" + course.organizationPath + "/" + enrollment.user.login + "-labs")!, label:{
                    Text(enrollment.user.name)
                        .frame(width: 180, alignment: .leading)
                })
                Spacer()
                
            }
            SwiftUI.Group{
                Text(enrollment.user.studentID)
                    .frame(width: 60, alignment: .leading)
                Spacer()
            }
            
            SwiftUI.Group{
                Link(destination: URL(string: "mailto:" + enrollment.user.email)!, label: {
                    Text(enrollment.user.email)
                        .frame(width: 200, alignment: .leading)
                })
                
                Spacer()
                    
            }
            
            SwiftUI.Group{
                Text("\(enrollment.lastActivityDate != "" ? enrollment.lastActivityDate : "Inactive")")
                    .frame(width: 50, alignment: .leading)
                Spacer()
            }
            
            SwiftUI.Group{
                Text("\(enrollment.totalApproved)")
                    .frame(width: 60, alignment: .center)
                Spacer()
            }
            
            SwiftUI.Group{
                if course.slipDays > 0 {
                    Text("\(enrollment.slipDaysRemaining)")
                        .frame(width: 60, alignment: .center)
                    Spacer()
                }
            }
        
            
                
            SwiftUI.Group{
                Text(translateUserStatus(status: enrollment.status))
                    .frame(width: 50, alignment: .leading)
            }
            
            
            
        }
    }
}

struct MemberListItem_Previews: PreviewProvider {
    static var previews: some View {
        MemberListItem(enrollment: Enrollment(), course: Course())
    }
}
