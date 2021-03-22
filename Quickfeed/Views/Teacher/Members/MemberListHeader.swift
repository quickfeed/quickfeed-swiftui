//
//  MemberListHeader.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 03/03/2021.
//

import SwiftUI

struct MemberListHeader: View {
    var courseTotalSlipDays: UInt32
    var body: some View {
        HStack{
            SwiftUI.Group{
                Text("Name")
                    .frame(width: 180, alignment: .leading)
                Spacer()
            }
            SwiftUI.Group{
                Text("StudentID")
                    .frame(width: 60, alignment: .leading)
                Spacer()
            }
            
            SwiftUI.Group{
                Text("Email")
                    .frame(width: 200, alignment: .leading)
                Spacer()
            }
            
            SwiftUI.Group{
                Text("Activity")
                    .frame(width: 50, alignment: .leading)
                Spacer()
            }
            
            SwiftUI.Group{
                Text("Approved")
                    .frame(width: 60, alignment: .center)
                Spacer()
            }
            
            SwiftUI.Group{
                if courseTotalSlipDays > 0 {
                    Text("Slip Days")
                        .frame(width: 60, alignment: .center)
                    Spacer()
                }
            }
        
            
                
            SwiftUI.Group{
                Text("Role")
                    .frame(width: 75, alignment: .center)
                
            }
        }
    }
}

struct MemberListHeader_Previews: PreviewProvider {
    static var previews: some View {
        MemberListHeader(courseTotalSlipDays: 2)
    }
}
